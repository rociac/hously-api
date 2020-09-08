Rails.application.routes.draw do
  scope '/api' do
    post 'user_token' => 'user_token#create'
    get '/users/current' => 'users#current'
    resources :users
    resources :houses
  end
end
