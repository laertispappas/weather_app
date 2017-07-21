require 'rails_helper'

describe City, type: :model do
  let(:params) do
    {
      id: 1,
      name: 'Athens',
      country: 'GR',
      weather: {
        icon: 'ico1',
        description: 'descr'
      }
    }
  end
  it 'initialization' do
    city = City.new(params.slice(:id, :name, :country).merge(weather: Weather.new(params[:weather])))

    weather = city.weather
    expect(weather.icon).to eq 'ico1'
    expect(weather.icon).to eq 'ico1'
    expect(weather.description).to eq 'descr'
  end
end
