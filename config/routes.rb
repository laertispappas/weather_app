Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'cities', to: 'weather#index'
      get 'weather', to: 'weather#show'
      get 'forecast', to: 'forecasts#show'
    end
  end
end
