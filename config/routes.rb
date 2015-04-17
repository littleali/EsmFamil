Rails.application.routes.draw do

  get 'chat/index'
  post 'chat/write' => 'chat#write'
  #resources :papers

  #resources :games

  resources :profiles

  resources :rooms

  get 'gamerooms/:name' => 'rooms#show_with_name'

  get 'gamerooms/:name/game/new' => 'rooms#new_game'
  post 'rooms/:name/create_game' => 'rooms#create_game'
  get 'gamerooms/:room_name/:game_title/papers' => 'games#show_papers'
  # devise_for :users
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'welcome/index' => 'welcome#index'
  get 'test' => 'welcome#test'

  post 'profiles/:id/update_field/:title' => "profiles#update_field"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#home'

  delete 'rooms/:id/kick_out/:user_id' => 'rooms#kick_out'
   # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
