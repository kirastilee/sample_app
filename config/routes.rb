Rails.application.routes.draw do
	get "/login", to: 'sessions#new'
	delete "/logout", to: "sessions#destroy"
	root to: "static_pages#home"
	get "/help", to:"static_pages#help"
	get "/about", to:"static_pages#about"
	resources :users
	get "/signup", to: "user#new"
	post "login", to: "sessions#create"
	resources :users do
		member do
			get :following, :followers
		end
	end
	resources :account_activations, only: [:edit]
	resources :password_resets, only: [:new, :create, :edit, :update]
	resources :microposts, only: [:create, :destroy]
	resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
