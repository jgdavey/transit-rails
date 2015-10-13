require 'spec_helper'
require 'transit/rails/renderer'
require 'active_support/core_ext/time'

describe Transit::Rails::Renderer do
  def render(obj, opts={}, io=StringIO.new)
    Transit::Rails::Renderer.new(obj, opts, io).render
  end

  def decode(io, handlers={})
    io = StringIO.new(io) unless io.respond_to?(:rewind)
    io.rewind
    Transit::Reader.new(:json, io, handlers: handlers).read
  end

  context "with custom handlers" do
    Point = Struct.new(:x, :y)
    point_handler = Class.new do
      def tag(o)
        "point"
      end

      def rep(o)
        [o.x, o.y]
      end

      def string_rep(o)
        rep(o).to_s
      end

      def from_rep(o)
        Point.new(o[0], o[1])
      end
    end

    it "correctly renders custom handlers at top level" do
      handlers = { Point => point_handler.new }

      io = StringIO.new
      point = Point.new(1,2)
      rendered = render(point, {handlers: handlers}, io)
      expect(point).to eq decode(rendered, {"point" => point_handler.new})
    end

    it "correctly uses custom handlers in an Array" do
      handlers = { Point => point_handler.new }

      io = StringIO.new
      points = [Point.new(1,2), Point.new(3,4)]
      rendered = render(points, {handlers: handlers}, io)
      expect(points).to eq decode(rendered, {"point" => point_handler.new})
    end

    it "passes the handlers to to_transit" do
      handlers = { Point => point_handler.new }

      io = StringIO.new
      points = [Point.new(1,2), Point.new(3,4)]
      expect(points).to receive(:to_transit).with(hash_including(handlers: hash_including(Point))).and_return("foo")
      rendered = render(points, {handlers: handlers}, io)
      expect(rendered).to eq "foo"
    end
  end

  context "verbosity" do
    it "can render verbose JSON" do
      obj = [Time.now, Time.now - 1]
      verbose = render(obj, verbose: true)
      terse   = render(obj)
      expect(verbose.length).to be > terse.length
    end
  end

  context "time with zone" do
    it "encodes ActiveSupport::TimeWithZone as a UTC time" do
      Time.zone = "EST"
      obj = Time.zone.now
      rendered = render(obj)
      # There's some truncation/rounding happening here, so strict equality
      # won't suffice
      expect(obj).to be_within(1).of(decode(rendered))
    end
  end
end
