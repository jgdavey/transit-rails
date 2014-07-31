module Transit
  module Rails
    class TimeWithZoneHandler
      def initialize
        @h = Transit::WriteHandlers::TimeHandler.new
      end

      def tag(o)
        @h.tag(o)
      end

      def rep(o)
        @h.rep(o)
      end

      def string_rep(o)
        @h.string_rep(o.to_time)
      end

      def verbose_handler() VerboseTimeWithZoneHandler.new end
    end

    class VerboseTimeWithZoneHandler
      def initialize
        @h = Transit::WriteHandlers::VerboseTimeHandler.new
      end

      def tag(o)
        @h.tag(o)
      end

      def rep(o)
        @h.rep(o)
      end

      def string_rep(o)
        @h.string_rep(o.to_time)
      end
    end

    TRANSIT_HANDLERS = { ActiveSupport::TimeWithZone => TimeWithZoneHandler.new }
  end
end
