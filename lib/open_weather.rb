require "open_weather/configuration"
require 'open_weather/base'
require 'open_weather/current'

module OpenWeather
  # A simple wrapper around OpenWeatherMap API.
  #
  extend Configuration
  extend self

  module CurrentWeatherMethods
    # Get weather data for a city.
    # @return [Hash] weather response as a hash
    #
    # Examples:
    #
    #   OpenWeather.city(city: 'Athens', country: 'Greece')
    #   OpenWeather.city(city: 'Athens', country: 'Greece', units: 'metric')
    #
    def city(**kwargs)
      Current.new(kwargs).fetch
    end
  end

  module ForeCastMethods
    # Get forecast data for a location
    #
    def forecast(**kwargs)
      Forecast.new(kwargs).fetch
    end
  end

  extend CurrentWeatherMethods
  extend ForeCastMethods
end
