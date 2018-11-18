Rails.application.routes.draw do
  resource :url
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :urls
    end
  end
end
