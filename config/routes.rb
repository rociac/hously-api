Rails.application.routes.draw do
  scope '/api' do
    post 'user_token' => 'user_token#create'
    post 'find_user' => 'users#find'
    resources :users
    resources :houses
  end
end
