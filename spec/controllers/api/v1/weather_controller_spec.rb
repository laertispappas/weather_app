require 'rails_helper'

module Api
  module V1
    describe WeatherController, type: :controller do
      describe 'GET #show' do
        context 'on success' do
          let(:weather_payload) {
            create_weather_payload(city: 'Athens', country: "GR")
          }

          before do
            stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?appid=#{OpenWeather.configuration.api_key}&q=Athens,GR&units=metric").
              to_return(status: 200, body: weather_payload.to_json)

            get :show, params: { format: :json, city: 'Athens', country: 'GR' }
          end

          it { expect(response).to be_success }

          it 'responds with the correct payload in JSON format' do
            expect(json['id']).to eq weather_payload['id']
            expect(json['name']).to eq 'Athens'
            expect(json['country']).to eq 'GR'
            icon_url = OpenWeather.configuration.icon_url.gsub(":icon", "01d.png")
            expect(json['weather']['icon']).to eq icon_url
            expect(json['weather']['description']).to eq 'clear sky'
          end
        end

        context 'whe city can not be found' do
          before do
            stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?appid=Some&q=?,?&&units=metric").
              to_return(status: 404, body: create_weather_not_found.to_json, headers: {})
            get :show, params: { format: :json, city: '?', country: '?' }
          end

          it { expect(response.status).to eq 404 }
          it { expect(json["error"]).to eq "City not found" }
        end

        context 'on other error' do
          before do
            stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?appid=Some&q=?,?&units=metric").
              to_return(status: 500, body: {stubbed: :response}.to_json, headers: {})
            get :show, params: { format: :json, city: '?', country: '?' }
          end

          it { expect(response.status).to eq 400 }
          it { expect(json['error']).to eq "500 Internal Server Error" }
        end
      end
    end
  end
end
