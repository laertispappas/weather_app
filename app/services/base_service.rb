module BaseService
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def call
    with_caching { handle_exception { Result::Success.new(super) } }
  end

  private

  def with_caching
    if cache_key.present?
      Rails.cache.fetch(cache_key, expires_params) { yield }
    else
      yield
    end
  end

  def cache_key
    if defined?(super)
      super
    else
      nil
    end
  end

  def expires_params
    if defined?(super)
      super
    else
      { expires_in: 3.hours }
    end
  end

  def handle_exception
    yield
  rescue OpenWeather::CityNotFoundError => e
    Result::Failure.new("City not found", { status: 404 })
  rescue OpenWeather::Error => e
    Result::Failure.new(e.message, { status: 400 })
  rescue StandardError => e
    Result::Failure.new('Internal server error', { status: 500 })
  end
end
