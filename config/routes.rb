Rails.application.routes.draw do
  scope '/api/v1' do
    namespace :user do
      post '/register' => 'user#register'
      post '/login' => 'user#login'
    end
    scope module: 'hotel' do
      get '/hotels' => 'hotels#index'
      resources :bookings, only: [:index, :create, :destroy]
      get '/bookings/my' => 'bookings#my'
      get '/bookings/:user_id' => 'bookings#index'
    end
  end
end
