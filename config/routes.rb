Rails.application.routes.draw do
  get '/', to: 'tasks#index'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks, except: :index do
    post :confirm, action: :confirm_new, on: :new
    patch :confirm, action: :confirm_edit, on: :member, as: :confirm_edit
  end
end
