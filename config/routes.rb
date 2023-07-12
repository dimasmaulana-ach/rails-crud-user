Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # name "/api/v1/user"
  namespace :api do
    namespace :v1 do
      resources :users
      post '/login', to: "auth#login"
    end
  end
end
