Rails.application.routes.draw do
  root 'meetings#index'
  get '/meetings/calendar' => 'meetings#calendar'
  resources :meetings do
    member do
      get :destroyAll
    end
  end
  resources :rooms
  resources :home, only: [:index]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
