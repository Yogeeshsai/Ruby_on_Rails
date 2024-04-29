Define routes in config/routes.rb:
Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  root to: "tasks#index"
end
