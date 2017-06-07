Rails.application.routes.draw do
  
  root 'static_pages#home'

  get 'sessions/new'
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :operations
  resources :professions
  resources :departments
  resources :addresses
  
  get    'users/delete_picture' => 'users#delete_picture'
  
  get    'signup'    => 'users#new'
  
  
  get    'help'      => 'static_pages#help'
  get    'home'      => 'static_pages#home'
  get    'game'      => 'static_pages#activ_game'
  get    'answers'   => 'static_pages#activ_question_answers'
  get    'beamer'    => 'static_pages#beamer'
  get    'about'     => 'static_pages#about'
  get    'contact'   => 'static_pages#contact'
  get    'menu'      => 'static_pages#menu'
  get    'admin_menu'=> 'static_pages#admin_menu'
  
  
  
  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'
  
  
end
