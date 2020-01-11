Rails.application.routes.draw do
	resources :users
	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	get 'logout', to: 'sessions#destroy',  as: 'logout' 
	get 'welcome', to: 'sessions#welcome'
	get 'authorized', to: 'sessions#page_requires_login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
