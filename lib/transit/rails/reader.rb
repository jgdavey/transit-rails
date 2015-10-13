require 'transit'
require 'transit/reader'

module Transit
  module Rails
    class Reader
      def self.make_reader(format)
        lambda do |raw|
          Transit::Reader.new(format, raw).read
        end
      end
    end
  end
end
