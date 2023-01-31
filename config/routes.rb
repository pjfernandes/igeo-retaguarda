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

  resources :subjects do
    resources :points
  end

  get '/api/subjects/users/:id', to: 'subjects#get_subjects'
  post 'api/subjects/post_subject', to: 'subjects#post_subject'

  post 'api/points/post_point', to: 'points#post_point'


  get '/api/points/users/:id', to: 'points#get_all_points_by_user'
  get '/api/users/:user_id/subjects/:subject_id/points', to: 'points#get_all_points_by_user_and_subject'

  get '/api/points/users/:id/last_point', to: 'points#get_last_point_id'


  get '/api/igeo_post', to: 'points#igeo_post'
  post '/api/igeo_post', to: 'points#igeo_post'

end
