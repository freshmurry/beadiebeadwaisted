Rails.application.routes.draw do

  root 'pages#home'
  get 'about' => 'pages#about' #creates about_path


  devise_for :users,
             :path => '',
             :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
             :controllers => {:omniauth_callbacks => 'omniauth_callbacks',
                              :registrations => 'registrations'
                             }
  
  resources :users, only: [:show]
  resources :beads
  resources :photos

  resources :beads do
    resources :orders, only: [:create]
  end

  resources :beads do
    resources :reviews, only: [:create, :destroy]
  end

  get '/preload' => 'orders#preload'
  get '/preview' => 'orders#preview'

  get '/past_orders' => 'orders#past_orders'
  get '/current_orders' => 'orders#current_orders'

  post '/notify' => 'orders#notify'
  post '/past_orders' => 'orders#your_trips'

  get '/search' => 'pages#search'

  resources :conversations, only: [:index, :create]  do		
     resources :messages, only: [:index, :create]
   end
   
end