Rails.application.routes.draw do

  get "sitemap.xml" => "sitemap#index", as: "sitemap", defaults: { format: "xml" }

  resources :issues, except: :index
  get 'archive', to: "issues#index"

  resources :verticals

  get 'home/*', to: redirect('/')
  get '/:year/*', to: redirect('/'), contraints: {year: /\b\d{4}\b/}
  get '/:volume/*', to: redirect('/'), contraints: {volume: /volume/}


  devise_for :subscribers,
    controllers: {registrations: 'subscribers/registrations'},
    path_names: {sign_in: "login", sign_out: "logout", sign_up: "subscribe"}

  get 'about', to: 'pages#about'

  get 'contact', to: 'pages#contact'

  get 'submit', to: 'pages#submit'

  get 'open-access-statement', to: 'pages#open_access'

  get 'call-for-submissions', to: 'pages#call_for_submissions'

  get 'most-recent', to: 'posts#index'

  get 'privacy-policy', to: 'pages#privacy_policy'

  resource :slideshow

  devise_for :editors,
    controllers: {registrations: :registrations},
    path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"}

  mount Ckeditor::Engine => '/ckeditor'

  resources :posts
  get '/editors/post-select', to: 'posts#type_select'
  get '/posts/new/:type', to: 'posts#new'
  resources :book_reviews, path: 'book-reviews'

  post 'posts/search', to: 'posts#search'

  post 'editor/posts', to: 'editors#manage_posts'
  post 'editor/book-reviews', to: 'editors#manage_book_reviews'
  post 'editor/issues', to: 'editors#manage_issues'

  post 'post/:id/publish', to: 'posts#publish', as: 'post_publish'
  post 'post/:id/unpublish', to: 'posts#unpublish', as: 'post_unpublish'
  get 'posts/vertical/:search', to: 'posts#vertical_sort'

  post 'book_review/:id/publish', to: 'book_reviews#publish', as: 'book_review_publish'
  post 'book_review/:id/unpublish', to: 'book_reviews#unpublish', as: 'book_review_unpublish'

  get 'interviews', to: 'posts#interviews', as: 'interviews'
  post 'interviews', to: 'posts#interviews'


  # Editor Routes (once logged in)
  get 'editor-panel', to: 'editors#panel', as: 'editor_panel'
  get 'editor/posts', to: 'editors#manage_posts', as: 'manage_posts'
  get 'editor/book_reviews', to: 'editors#manage_book_reviews', as: 'manage_book_reviews'
  get 'editor/issues', to: 'editors#manage_issues', as: 'manage_issues'

  resources :editors

  root 'posts#index'

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
