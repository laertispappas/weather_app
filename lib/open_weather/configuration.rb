module OpenWeather
  module Configuration
    CONFIG_ATTRS = [:api_key, :icon_url, :default_unit].freeze

    def configure
      return unless block_given?
      yield configuration if block_given?
    end

    def configuration
      @config ||= Configuration.new
    end

    class Configuration < Struct.new(*CONFIG_ATTRS)
      def initialize
        super

        set_default_values
      end

      private
      def set_default_values
        self.api_key = nil
        self.icon_url = "http://openweathermap.org/img/w/:icon"
        self.default_unit = 'metric'
      end
    end
  end
end
