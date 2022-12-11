Rails.application.routes.draw do
  devise_for :users

  root to: "dashboard#index"

  resources :categories, except: :show
  resources :courses
end
