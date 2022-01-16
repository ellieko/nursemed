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

end
