module Api
  module V1
    class WeatherController < ApplicationController
      def show
        WeatherService.new(params).call.on_success { |weather|
          render json: weather
        }.on_failure {|error_msg, data|
          render json: { error: error_msg }, status: data[:status]
        }
      end
    end
  end
end
