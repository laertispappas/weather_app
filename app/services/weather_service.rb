class WeatherService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  # TODO transform to internal entity (DAO) instead passing
  # directly the response to client
  def get_city
    current = OpenWeather.city(name: params[:city], country: params[:country])
    Result::Success.new(build_city(current))

  rescue OpenWeather::CityNotFoundError => e
    Result::Failure.new("City not found", { status: 404 })
  rescue OpenWeather::Error => e
    Result::Failure.new(e.message, { status: 400 })
  end


  private

  def build_city(current)
    City.new.tap do |city|
      city.name = current['name']
      city.id = current['id']
      city.country = current['sys']['country']
      city.weather = build_weather(current['weather'])
    end
  end

  def build_weather(weather)
    Weather.new.tap do |instance|
      instance.description = weather[0]['description']
      instance.icon = OpenWeather.configuration.icon_url.gsub(":icon", "#{weather[0]['icon']}.png")
    end
  end
end
