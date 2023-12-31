Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    devise_for :users,
      controllers: {
        sessions: 'api/sessions',
        registrations: 'api/registrations'
      }

    resources :cars do
      member do
        delete 'destroy'
      end
    end

    get 'all_cars', to: 'cars#index'
    get 'cars/:id', to: 'cars#show'
    post 'car/new_car', to: 'cars#create'
    get 'my_reservations', to: 'my_reservations#index'
    post 'car/:car_id/new_reserve', to: 'my_reservations#create'
  end
end
