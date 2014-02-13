Bloccit::Application.routes.draw do

  get "posts/index"
	match "api/foobar" => 'api#foobar', via: :get
 
  get "comments/create"
 #devise_for :users,  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
 devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :users, only: [:show, :index] # create a route for users#show

  resources :posts, only: [:index]

 resources :topics do
   resources :posts, except: [:index], controller: 'topics/posts' do 
    resources :comments, only: [:create, :destroy]
    match '/up-vote', to: 'votes#up_vote', as: :up_vote, via: [:get, :post]
    match '/down-vote', to: 'votes#down_vote', as: :down_vote, via: [:get, :post]
    resources :favorites, only: [:create, :destroy]
   end
  end

 match "about" => 'welcome#about', via: :get

  
  root to:  'welcome#index'
end
