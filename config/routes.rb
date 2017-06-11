# Diese Datei kümmert sich um das Weiterleiten der Browser Anfragen
Rails.application.routes.draw do
  
  # Zunächst definieren wir mit 'root', was unsere Startseite ist
  root 'static_pages#home'
  
  # SSE Test
  get 'user_stream' => 'users#index_stream'
  get 'user_watch' => 'users#watch'
  # SSE Ende Test

  # Definieren wir erstmal unsere nicht so interessanten Seiten
  # Es gibt einen Controller 'StaticPages', welcher uns einfach nur "statische"
  # Seiten Anzeigen lassen soll. 
  
  # Es gilt: get 'DieUrlDerSeite' => 'ControlerNamen # Methode'
  # Bsp. mit '...de/help' wird die Methode 'help' des Controller 'StaticPages'
  # aufgerufen
  get    'help'      => 'static_pages#help' 
  get    'home'      => 'static_pages#home' # Die Startseite
  get    'about'     => 'static_pages#about' 
  get    'contact'   => 'static_pages#contact'
  get    'admin_menu'=> 'static_pages#admin_menu' # Die Admin Menu Seite

  # Definieren wir als nächstes, welche Modelle wir sehen wollen
  # Die Standartmethoden werden hierdurch erlaubt
  resources :firecars
  resources :users
  resources :professions
  resources :departments
  resources :addresses
  resources :operations do
    member do
      # Weiterhin wird die Methode 'map' erlaubt/definiert
      # Diese leitet die Anfrage an den 'OperationController'
      # weiter an die gleichnamige Methode
      get 'map' 
    end
  end
  
  # Routen für Passwörter etc.
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  
  get    'users/delete_picture' => 'users#delete_picture'
  get    'signup'    => 'users#new'
  
  

  
  
  post   'static_pages/call_controller_post_method' => 'static_pages#call_controller_post_method'
  get   'static_pages/call_controller_method' => 'static_pages#call_controller_method'
  
  # Routen zum erstellen einer Session
  get 'sessions/new'
  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'
  
  
end
