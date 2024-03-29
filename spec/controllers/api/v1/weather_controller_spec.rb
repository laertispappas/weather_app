require 'rails_helper'

module Api
  module V1
    describe WeatherController, type: :controller do
      describe 'GET #index' do

        context 'on success' do
          let(:find_response) { find_cities }
          before do
            stub_request(:get, "http://api.openweathermap.org/data/2.5/find?appid=Some&lat=0.0&lon=0.0&units=metric").
              to_return(status: 200, body: find_response.to_json, headers: {})

            get :index, params: { format: :json }
          end

          it 'responds with the correct payload' do
            expect(json.size).to eq 3
            list = find_response['list']

            expect(json[0]['city']['id']).to eq list[0]['id']
            expect(json[0]['city']['name']).to eq list[0]['name']
            expect(json[0]['city']['country']).to eq list[0]['country']
            details = json[0]['details'][0]
            expect(details['temp']).to eq list[0]['main']['temp']
            expect(details['pressure']).to eq list[0]['main']['pressure']
            expect(details['min_temp']).to eq list[0]['main']['temp_min']
            expect(details['max_temp']).to eq list[0]['main']['temp_max']
            expect(details['clouds']).to eq list[0]['clouds']['all']
            expect(details['wind_speed']).to eq list[0]['wind']['speed']
            weather = details['weather']
            expect(weather['description']).to eq list[0]['weather'][0]['description']

            expect(json[1]['city']['id']).to eq list[1]['id']
            expect(json[1]['city']['name']).to eq list[1]['name']
            expect(json[1]['city']['country']).to eq list[1]['country']
            details = json[1]['details'][0]
            expect(details['temp']).to eq list[1]['main']['temp']
            expect(Time.parse(details['datetime'])).to eq Time.at(list[1]['dt'])
            expect(details['pressure']).to eq list[1]['main']['pressure']
            expect(details['min_temp']).to eq list[1]['main']['temp_min']
            expect(details['max_temp']).to eq list[1]['main']['temp_max']
            expect(details['clouds']).to eq list[1]['clouds']['all']
            expect(details['wind_speed']).to eq list[1]['wind']['speed']
            weather = details['weather']
            expect(weather['description']).to eq list[1]['weather'][0]['description']

            expect(json[2]['city']['id']).to eq list[2]['id']
            expect(json[2]['city']['name']).to eq list[2]['name']
            expect(json[2]['city']['country']).to eq list[2]['country']
            details = json[0]['details'][0]
            expect(details['temp']).to eq list[2]['main']['temp']
            expect(details['pressure']).to eq list[2]['main']['pressure']
            expect(details['min_temp']).to eq list[2]['main']['temp_min']
            expect(details['max_temp']).to eq list[2]['main']['temp_max']
            expect(details['clouds']).to eq list[2]['clouds']['all']
            expect(details['wind_speed']).to eq list[2]['wind']['speed']
            weather = details['weather']
            expect(weather['description']).to eq list[2]['weather'][0]['description']
          end
        end

        context 'on failure' do
          let(:exception) { StandardError.new('None') }
          before do
            allow(OpenWeather).to receive(:find).and_raise(exception)
            get :index, params: { format: :json }
          end

          it { expect(json['error']).to eq 'Internal server error' }
          it { expect(response.status).to eq 500 }
        end
      end
    end
  end
end
