Rails.application.routes.draw do
  devise_for :users
  resources :tasks do
    resources :notes, only: [:create], controller: 'tasks/notes'
  end
  resources :categories

  root 'tasks#index'
end
