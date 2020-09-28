Rails.application.routes.draw do
  devise_for :users
  root to: "tasks#top"
  resources :tasks
  post 'tasks/:id/repeat', to: 'tasks#repeat'
  post 'tasks/create', to: 'tasks#create_task'
end
