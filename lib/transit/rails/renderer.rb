require 'transit'
require 'transit/writer'
require 'transit/rails/handlers'

module Transit
  module Rails
    class Renderer
      attr_reader :io

      def initialize(obj, options={}, io=StringIO.new)
        @object = obj
        @format = options[:verbose] ? :json_verbose : :json
        @handlers = TRANSIT_HANDLERS.merge(options[:handlers] || {})
        @io = io
        @symbolize_keys = options[:symbolize_keys]
      end

      def write
        serialized = serialize_for_transit(@object)
        Transit::Writer.new(@format, @io, handlers: @handlers).write(serialized)
      end

      def render
        return @rendered if defined?(@rendered)
        if @object.respond_to?(:to_transit)
          @rendered = @object.to_transit(handlers: @handlers)
        else
          write
          @io.rewind
          @rendered = @io.read
        end
      end

      def to_s
        render
      end
      alias to_str to_s

      private
      def serialize_for_transit(obj)
        return obj if String === obj
        if obj.respond_to?(:as_transit)
          obj.to_transit
        elsif obj.respond_to?(:serializable_hash)
          if @symbolize_keys
            obj.serializable_hash.symbolize_keys
          else
            obj.serializable_hash
          end
        elsif obj.respond_to?(:to_ary)
          obj.to_ary.map {|o| serialize_for_transit(o)}
        else
          obj
        end
      end
    end
  end
end
