Rails.application.routes.draw do
  resources :foos
  # root "home#index"
  root "api/v1/urls#index"

  namespace :api do
    namespace :v1 do
      resources :urls, only: [:index, :create]
    end
  end
  get "*slug", to: "redirect_url#index"
end
