Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "subjects#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :points

  resources :users do
    resources :subjects do
      resources :points
    end
  end

end
