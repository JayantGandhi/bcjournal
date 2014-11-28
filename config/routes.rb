Rails.application.routes.draw do

  resources :verticals

  devise_for :subscribers,
    controllers: {registrations: 'subscribers/registrations'},
    path_names: {sign_in: "login", sign_out: "logout", sign_up: "subscribe"}

  get 'about', to: 'pages#about'

  get 'contact', to: 'pages#contact'

  get 'submit', to: 'pages#submit'

  get 'call-for-submissions', to: 'pages#call_for_submissions'

  resource :slideshow

  devise_for :editors,
    controllers: {registrations: :registrations},
    path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"}

  mount Ckeditor::Engine => '/ckeditor'
  resources :posts

  post 'post/:id/publish', to: 'posts#publish', as: 'post_publish'
  post 'post/:id/unpublish', to: 'posts#unpublish', as: 'post_unpublish'

  # Editor Routes (once logged in)
  get 'editor-panel', to: 'editors#panel', as: 'editor_panel'
  get 'editor/posts', to: 'editors#manage_posts', as: 'manage_posts'
  post 'editor/create', to: 'editors#create', as: 'editor_create_path'
  resources :editors

  # root 'posts#index'

  root 'pages#splash'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
