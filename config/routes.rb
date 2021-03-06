Rails.application.routes.draw do

  #resources :papers

  #resources :games

  get 'profiles/search/'=> 'profiles#search', as: :user_search
  
  resources :profiles

  resources :rooms

  # get 'gamerooms/:name' => 'rooms#show_with_name'
  # get 'gamerooms/:name/game/new' => 'rooms#new_game'
  get 'rooms/:id/game/new' => 'rooms#new_game'
  post 'rooms/:id/create_game' => 'rooms#create_game'
  post 'game/end_game/:id' => 'games#end_game'
  get 'game/end_game/:id' => 'games#end_game', as: :end_game
#  post 'games/:game_id/paper/:paper_id/:item_name' => 'games#save_paper_field'
  post 'games/:game_id/paper/:p_id/:pf_id/' => 'games#save_paper_field'

  get 'rooms/:id/games/:g_id/judgement' => 'games#judgement', as: :judgement
  # get 'profile' => 'room#update'
  get 'rooms/:id/games/:game_id/papers' => 'games#show_papers'
  post 'rooms/:id/games/:game_id/start' => 'games#start'
  get 'rooms/:id/games/:game_id' => 'games#show'
  # devise_for :users
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'welcome/index' => 'welcome#index'
  get 'test' => 'welcome#test'

  get 'games/accept_field/:p_id/:pf_id' => 'games#accept_field'
  get 'games/reject_field/:p_id/:pf_id' => 'games#reject_field'

  get 'rooms/accept_invitation/:p_id/:r_id' => 'rooms#accept_invitation'
  get 'rooms/reject_invitation/:p_id/:r_id' => 'rooms#reject_invitation'

  post 'profiles/:id/update_field/:title' => "profiles#update_field"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#home'

  patch 'rooms/:id/send_invitation/:profile_id' => 'rooms#send_invitation' , as: :send_invitation
  patch 'rooms/:id/join' => 'rooms#join', as: :join_room
  delete 'rooms/:id/kick_out/:profile_id' => 'rooms#kick_out' 
  delete 'rooms/:id/leave' => 'rooms#leave', as: :leave_room
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
