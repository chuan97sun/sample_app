Rails.application.routes.draw do	
  root "static_page#home"
  get "/help", to: "static_page#help"
  get "/signup", to: "users#new"
end
