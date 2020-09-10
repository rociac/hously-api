Rails.application.routes.draw do
  scope '/api' do
    post 'user_token' => 'user_token#create'
    get '/users/current' => 'users#current'
    get '/favorites' => 'favorites#index'
    post '/favorites' => 'favorites#create'
    delete '/favorites' => 'favorites#destroy'
    get '/favorited' => 'favorites#favorited'
    resources :users
    resources :houses
  end
end
