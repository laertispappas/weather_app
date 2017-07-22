class WeatherBuilder
  def self.build(weather)
    Weather.new.tap do |instance|
      instance.description = weather['description']
      instance.icon = OpenWeather.configuration.icon_url.gsub(":icon", "#{weather['icon']}.png")
    end
  end
end
