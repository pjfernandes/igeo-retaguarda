Rails.application.routes.draw do
  devise_for :users
  root to: "subjects#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :points

  resources :subjects, model_name: 'Subject' do
    resources :points
  end

end
