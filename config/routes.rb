Rails.application.routes.draw do
  devise_for :users

  root to: 'dashboard#index'

  resources :categories, except: :show
  resources :courses
  resources :teachers, except: :show
  resources :people, except: :show

  resources :courses, only: [] do
    resources :subscriptions
  end
end
