require 'transit'
require 'transit/reader'

module Transit
  module Rails
    class Reader
      
      def self.make_reader (format)
        Proc.new do |raw_post|
          Transit::Reader.new(format, raw_post).read
        end
      end

    end
  end
end
