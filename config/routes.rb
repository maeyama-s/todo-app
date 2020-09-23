Rails.application.routes.draw do
  get 'tasks/index'
  devise_for :users
  root to: "tasks#index"
end
