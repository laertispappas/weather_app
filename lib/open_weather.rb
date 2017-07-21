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
    #   OpenWeather.city(name: 'Athens', country: 'Greece')
    #
    def city(name: nil, country: nil)
      Current.new(name: name, country: country).fetch
    end
  end

  extend CurrentWeatherMethods
end
