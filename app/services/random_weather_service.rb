class RandomWeatherService
  prepend BaseService

  def call
    location = Geocoder.search(params[:client_ip]).first
    result = OpenWeather.find(lat: location.latitude,
                              lon: location.longitude)

    build(result)
  end

  private
  def build(result)
    result['list'].map do |item|
      build_forecast(item)
    end
  end

  def build_forecast(item)
    Forecast.new.tap do |forecast|
      forecast.city = City.new(id: item['id'], name: item['name'])
      forecast.details = [build_forecast_details(item)]
    end
  end

  def build_forecast_details(item)
    ForecastDetails.new(
      datetime: Time.at(item['dt']),
      temp: item['main']['temp'],
      min_temp: item['main']['temp_min'],
      max_temp: item['main']['temp_max'],
      pressure: item['main']['pressure'],
      clouds: item['clouds']['all'],
      wind_speed: item['wind']['speed'],
      weather: WeatherBuilder.build(item['weather'][0])
    )
  end
end
