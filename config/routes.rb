Rails.application.routes.draw do	
  scope "(:locale)", locale: /en/ do
    root "static_page#home"
    get "/help", to: "static_page#help"
    get "/signup", to: "users#new"
    resources :users
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index show destroy)
    resources :microposts, only: %i(create destroy)
    resources :relationships, only: %i(create destroy)
    resources :users do
      member do
        get :following, to: "follows#following"
        get :followers, to: "follows#followers"
      end
    end
  end
end
