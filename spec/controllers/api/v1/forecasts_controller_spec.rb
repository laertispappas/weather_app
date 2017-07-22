require 'rails_helper'

module Api
  module V1
    describe ForecastsController, type: :controller do
      describe 'GET #show' do
        context 'on success' do
          let(:forecast_response) { create_forecast_response(city: 'Athens', country: 'GR') }
          before do
            stub_request(:get, "http://api.openweathermap.org/data/2.5/forecast?appid=Some&q=Athens,GR&units=metric").
              to_return(status: 200, body: forecast_response.to_json, headers: {})

            get :show, params: { format: :json, city: 'Athens', country: 'GR' }
          end

          it { expect(response).to be_success }
          it 'responds with the correct forecast payload' do
            expect(json['city']['name']).to eq 'Athens'
            expect(json['city']['id']).to eq forecast_response['city']['id']
            expect(json['city']['country']).to eq 'GR'

            expect(Time.parse(json['details'][0]['datetime'])).to eq Time.parse("2014-07-23 09:00:00")
            expect(json['details'][0]['temp']).to eq forecast_response['list'][0]['main']['temp']
            expect(json['details'][0]['min_temp']).to eq forecast_response['list'][0]['main']['temp_min']
            expect(json['details'][0]['max_temp']).to eq forecast_response['list'][0]['main']['temp_max']
            expect(json['details'][0]['pressure']).to eq forecast_response['list'][0]['main']['pressure']
            expect(json['details'][0]['clouds']).to eq forecast_response['list'][0]['clouds']['all']
            expect(json['details'][0]['wind_speed']).to eq forecast_response['list'][0]['wind']['speed']

            expect(json['details'][0]['weather']['description']).to eq "overcast clouds"
            expect(json['details'][0]['weather']['icon']).to eq "http://openweathermap.org/img/w/04d.png"

            expect(Time.parse(json['details'][1]['datetime'])).to eq Time.parse("2014-07-23 12:00:00")
            expect(json['details'][1]['temp']).to eq forecast_response['list'][1]['main']['temp']
            expect(json['details'][1]['min_temp']).to eq forecast_response['list'][1]['main']['temp_min']
            expect(json['details'][1]['max_temp']).to eq forecast_response['list'][1]['main']['temp_max']
            expect(json['details'][1]['pressure']).to eq forecast_response['list'][1]['main']['pressure']
            expect(json['details'][1]['clouds']).to eq forecast_response['list'][1]['clouds']['all']
            expect(json['details'][1]['wind_speed']).to eq forecast_response['list'][1]['wind']['speed']

            expect(json['details'][1]['weather']['description']).to eq "overcast clouds2"
            expect(json['details'][1]['weather']['icon']).to eq "http://openweathermap.org/img/w/05d.png"
          end
        end

        # TODO DRY this
        context 'on failure' do
        end

        # TODO DRY this
        context 'when the city can not be found'
      end
    end
  end
end
