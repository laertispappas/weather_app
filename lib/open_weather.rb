require "open_weather/configuration"
require 'open_weather/base'
require 'open_weather/current'
require 'open_weather/finder'
require 'open_weather/forecast'

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
      OpenWeather::Current.new(kwargs).fetch
    end

    def find(**kwargs)
      OpenWeather::Finder.new(kwargs).fetch
    end
  end

  module ForeCastMethods
    # Get forecast data for a location
    #
    def forecast(**kwargs)
      OpenWeather::Forecast.new(kwargs).fetch
    end
  end

  extend CurrentWeatherMethods
  extend ForeCastMethods
end
