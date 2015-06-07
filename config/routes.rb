Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :cards, only: [:index]
      post "upload", to: "upload#upload"
    end
  end
end
