Rails.application.routes.draw do
  devise_for :users
  resource :user, only: :show
  root to: 'tasks#index'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks, except: :index do
    post :confirm, action: :confirm_new, on: :new
    patch :confirm, action: :confirm_edit, on: :member, as: :confirm_edit
    post :import, on: :collection
    resources :change_status, only: :update, module: :tasks
  end
end
