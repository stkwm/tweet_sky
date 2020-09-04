Rails.application.routes.draw do
  get 'posts/new' => 'posts#new'
  post 'posts/create' => 'posts#create'
  get 'posts/index' => 'posts#index'
  get 'posts/:id' => 'posts#show'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'

  get 'signup' => 'users#new'
  post 'users/create' => 'users#create'
  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  get 'users/index' => 'users#index'
  get '/users/search_result' => 'users#search'
  get 'users/:id' => 'users#show'
  get 'users/:id/edit' => 'users#edit'
  post 'users/:id/update' => 'users#update',as: :user_update
  get 'users/:id/likes' => 'users#likes'
  get 'users/:id/follows' => 'users#follows'
  
  post 'likes/:post_id/create' => 'likes#create'
  post 'likes/:post_id/destroy' => 'likes#destroy'
  
  post 'follows/:id/create' => 'follows#create',as: :follow_create
  post 'follows/:id/destroy' => 'follows#destroy',as: :follow_destroy

  get '/' => 'home#top'
  get 'about' => 'home#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
