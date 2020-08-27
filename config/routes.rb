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
  end
end
