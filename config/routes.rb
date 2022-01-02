Rails.application.routes.draw do

  root 'sessions#new'
  resources :nurses do
    resources :meetings
  end

  resources :guardians, only: :show
  post 'nurses/:nurse_id/meetings/:id/log' => 'meetings#log', as: :log
  post 'nurses/:nurse_id/meetings/:id/error' => 'meetings#error', as: :error
  get 'nurses/:nurse_id/meetings/:id/error' => 'meetings#error'
  post 'nurses/:nurse_id/meetings/:id/adderror' => 'meetings#adderror', as: :adderror
  get 'nurses/:nurse_id/meetings/:id/adderror' => 'meetings#adderror'


  resources :students do
    resources :medication_assignments
  end
  resources :guardians
  resources :schools
  resources :medications

  get 'administrators/stats'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'
  post '/auth/failure', :to => 'sessions#failure'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'

  get '/students/:id/transfer', to: 'students#transfer', as: :transfer_student
  post '/students/:id/transfer', to: 'students#transfer_update'

  get '/students/:student_id/medication_assignments/:id/destroy', to: 'medication_assignments#destroy', as: :destroy_assignment
  get '/schools/:id/destroy', to: 'schools#destroy', as: :destroy_school
  get '/medications/:id/destroy', to: 'medications#destroy', as: :destroy_medication


  # map '/' to be a redirect to '/movies'
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
