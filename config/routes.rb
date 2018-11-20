Rails.application.routes.draw do
  root "home#index"

  namespace :api do
    namespace :v1 do
      resources :urls
    end
  end


  get "*slug", to: "redirect_url#index"
end
