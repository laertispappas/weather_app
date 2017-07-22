module BaseService
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def call
    handle_exception { Result::Success.new(super) }
  end

  private

  def handle_exception
    yield
  rescue OpenWeather::CityNotFoundError => e
    Result::Failure.new("City not found", { status: 404 })
  rescue OpenWeather::Error => e
    Result::Failure.new(e.message, { status: 400 })
  end

end
