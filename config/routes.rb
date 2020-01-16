# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#              user_details GET    /users/:user_id/details(.:format)                                                        details#index
#                           POST   /users/:user_id/details(.:format)                                                        details#create
#           new_user_detail GET    /users/:user_id/details/new(.:format)                                                    details#new
#          edit_user_detail GET    /users/:user_id/details/:id/edit(.:format)                                               details#edit
#               user_detail GET    /users/:user_id/details/:id(.:format)                                                    details#show
#                           PATCH  /users/:user_id/details/:id(.:format)                                                    details#update
#                           PUT    /users/:user_id/details/:id(.:format)                                                    details#update
#                           DELETE /users/:user_id/details/:id(.:format)                                                    details#destroy
#                     users GET    /users(.:format)                                                                         users#index
#                           POST   /users(.:format)                                                                         users#create
#                  new_user GET    /users/new(.:format)                                                                     users#new
#                 edit_user GET    /users/:id/edit(.:format)                                                                users#edit
#                      user GET    /users/:id(.:format)                                                                     users#show
#                           PATCH  /users/:id(.:format)                                                                     users#update
#                           PUT    /users/:id(.:format)                                                                     users#update
#                           DELETE /users/:id(.:format)                                                                     users#destroy
#                     login GET    /login(.:format)                                                                         sessions#new
#                           POST   /login(.:format)                                                                         sessions#create
#                    logout GET    /logout(.:format)                                                                        sessions#destroy
#                   welcome GET    /welcome(.:format)                                                                       sessions#welcome
#                authorized GET    /authorized(.:format)                                                                    sessions#page_requires_login
#                   details POST   /details(.:format)                                                                       details#create
#                    detail DELETE /details/:id(.:format)                                                                   details#destroy
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
	resources :users do
		resources :details
		member do
			get :confirm_email
			post :invitation_email 
			post :activate
			post :deactivate
			post :feature
			delete :unfeature
		end
	end
	root to: 'sessions#welcome'
	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	patch 'users/:user_id/edit/:id', to: 'details#update'
	get 'logout', to: 'sessions#destroy',  as: 'logout'
	get 'welcome', to: 'sessions#welcome'
	get 'authorized', to: 'sessions#page_requires_login'
  resources :details, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
