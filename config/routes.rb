Rails.application.routes.draw do
	
  root "static_page#home"
   get "static_page/home"
   get "static_page/help"
  end
