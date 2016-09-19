Rails.application.routes.draw do
  scope '/api/v1' do
    namespace :user do
      post '/register' => 'user#register'
      post '/login' => 'user#login'
    end
    scope module: 'hotel' do
      get '/hotels' => 'hotels#index'
      resources :bookings, only: [:index, :create, :update, :show, :destroy]
    end
  end
end
