class ForecastService
  prepend BaseService

  def call
    forecast = OpenWeather.forecast(city: params[:city],
                                    country: params[:country],
                                    id: params[:id],
                                    units: params[:units])

    build_forecast(forecast)
  end

  private

  def cache_key
    key = ""
    key += params[:city] if params[:city].present?
    key += params[:country] if params[:country].present?
    key += params[:id] if params[:id].present?
    key += params[:unit] if params[:unit].present?
    key
  end

  def build_forecast(forecast)
    Forecast.new.tap do |instance|
      instance.city = build_city(forecast['city'])
      instance.details = build_weather_details(forecast['list'])
    end
  end

  def build_city(city)
    City.new(name: city['name'], id: city['id'], country: city['country'])
  end

  def build_weather_details(weather_list)
    weather_list.map do |current|
      ForecastDetails.new(datetime: current['dt_txt'],
                          temp: current['main']['temp'],
                          min_temp: current['main']['temp_min'],
                          max_temp: current['main']['temp_max'],
                          pressure: current['main']['pressure'],
                          clouds: current['clouds']['all'],
                          wind_speed: current['wind']['speed'],
                          weather: WeatherBuilder.build(current['weather'][0]))
    end
  end
end
