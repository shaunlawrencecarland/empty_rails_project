Rails.application.routes.draw do
  root "home#index"
  resources :urls, only: [:index, :create]

  get "*slug", to: "redirect_url#index"
end
