module Api
  module V1
    class ForecastsController < ApplicationController
      def show
        ForecastService.new(params).call.on_success {|forecast|
          render json: forecast
        }.on_failure { |error_msg, data|
          render json: { error: error_msg }, status: data[:status]
        }
      end
    end
  end
end
