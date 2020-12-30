Rails.application.routes.draw do
  	get '/login' , to: "sessions#new"
	root to: "static_pages#home"
	get "/help", to:"static_pages#help"
	get "/about", to:"static_pages#about"
	resources :users
	delete "/logout", to: "sessions#destroy"
	get "signup" , to: "users#new"
	post "/login", to: "sessions#create" 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
