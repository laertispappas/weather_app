class WeatherService
  prepend BaseService

  def initialize(params)
    @params = params
  end

  def call
    current = OpenWeather.city(city: params[:city],
                               country: params[:country],
                               units: params[:units])

    build_city(current)
  end

  private

  def build_city(current)
    City.new.tap do |city|
      city.name = current['name']
      city.id = current['id']
      city.country = current['sys']['country']
      city.weather = WeatherBuilder.build(current['weather'][0])
    end
  end
end
