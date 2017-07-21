
module OpenWeather
  class Current < Base

    private

    def endpoint
      'weather'
    end

    def extract_options(options)
      if options[:name] || options[:country]
        options[:q] = "#{options[:name]},#{options[:country]}"
        options.delete(:name)
        options.delete(:country)
      end

      super
    end
  end
end
