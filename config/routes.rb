Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :weather, only: [:show]
      resource :forecast, only: [:show]
    end
  end
end
