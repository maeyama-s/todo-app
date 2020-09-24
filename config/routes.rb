Rails.application.routes.draw do
  devise_for :users
  root to: "tasks#top"
  resources :tasks, only: [:index, :new, :create, :show, :edit, :update, :destroy]
end
