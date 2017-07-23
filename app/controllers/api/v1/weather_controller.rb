module Api
  module V1
    class WeatherController < ApplicationController
      def index
        RandomWeatherService.new(client_ip: request.remote_ip).call.on_success { |cities|
          render json: cities
        }.on_failure { |msg, data|
          render json: { error: msg }, status: data[:status]
        }
      end
    end
  end
end
