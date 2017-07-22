require 'rails_helper'

describe OpenWeather do
  subject { OpenWeather }

  it { expect(subject).to be_a OpenWeather::Configuration }

  describe '.configure' do
    context 'when block given' do
      it 'should be able to set configuration values' do
        subject.configure do |config|
          config.api_key = 'token'
        end

        expect(subject.configuration.api_key).to eq 'token'
      end
    end
    context 'when no block is given' do
      it { expect(subject.configure).to be_nil }
    end
  end

  describe 'ForecastMethods' do
    context '.forecast' do
      context 'on valid request' do
        let(:response_hash) { create_forecast_response }

        subject { OpenWeather.forecast(city: 'Athens', country: 'Greece') }

        before do
          stub_request(:get, "http://api.openweathermap.org/data/2.5/forecast?appid=#{OpenWeather.configuration.api_key}&q=Athens,Greece&units=metric").
            to_return(status: 200, body: response_hash.to_json, headers: {})
        end

        it { expect(subject).to eq response_hash }
      end
    end
  end

  describe 'CurrentWeatherMethods' do
    context '.city' do
      subject { OpenWeather.city(city: 'Athens', country: 'Greece') }

      context 'Given a valid request' do
        let(:weather_payload) do
          create_weather_payload(city: 'Athens', country: "GR", id: 1)
        end

        before do
          stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?appid=#{OpenWeather.configuration.api_key}&q=Athens,Greece&units=metric").
            to_return(status: 200, body: weather_payload.to_json, headers: {})
        end

        it { expect(subject).to eq weather_payload }
      end

      context 'When the city can not be found' do
        let(:response) { create_weather_not_found }

        before do
          stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?appid=#{OpenWeather.configuration.api_key}&q=Athens,Greece").
            to_return(status: 404, body: response.to_json, headers: {})
        end

        it { expect{subject}.to raise_error{ OpenWeather::CityNotFoundError } }
      end

      context 'Given an unauthorized request' do
        let(:response) { create_anuthorized_response }

        before do
          stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?appid=#{OpenWeather.configuration.api_key}&q=Athens,Greece").
            to_return(status: 401, body: response.to_json, headers: {})
        end

        it { expect{subject}.to raise_error{ OpenWeather::Error } }
      end

      context 'Given a bad request' do
        let(:response) { create_bad_request_payload }

        before do
          stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?appid=#{OpenWeather.configuration.api_key}&q=Athens,Greece").
            to_return(status: 400, body: response.to_json, headers: {})
        end

        it { expect{subject}.to raise_error{ OpenWeather::Error } }
      end
    end
  end
end
