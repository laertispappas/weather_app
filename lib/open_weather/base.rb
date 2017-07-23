require 'net/http'
require 'json'

module OpenWeather
  class Error < StandardError; end
  class CityNotFoundError < Error; end

  module HttpClient
    def get(url)
      RestClient.get(url, params: options)

    rescue RestClient::ResourceNotFound => e
      raise CityNotFoundError.new(e)
    rescue RestClient::Exception => e
      raise Error.new(e)
    end
  end

  class Base
    include HttpClient

    VALID_ATTRS = [:city, :country, :units, :lat, :lon, :id]

    attr_reader :options

    def initialize(**options)
      @options = extract_options(options)
    end

    def fetch
      parse_response(get(url))
    end

    private
    def extract_options(options)
      options = options.slice(* VALID_ATTRS)
      options[:appid] = OpenWeather.configuration.api_key

      options.each { |k, v| options.delete(k) if options[k].nil? }

      if options[:city] || options[:country]
        options[:q] = "#{options[:city]},#{options[:country]}"
        options.delete(:city)
        options.delete(:country)
      end

      options[:units] ||= OpenWeather.configuration.default_unit

      options
    end

    def url
      "http://api.openweathermap.org/data/2.5/#{endpoint}"
    end

    def endpoint
      raise NotImplementedError, 'Abstract method'
    end

    def parse_response(response)
      JSON.parse(response)
    end
  end
end
