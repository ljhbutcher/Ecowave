Rails.application.routes.draw do
  devise_for :users

  root to: "pages#landing_page"
  get "/home", to: "pages#home"

  resources :projects do
    resources :project_materials, only: [:new, :create, :show]
    resources :materials, controller: 'project_materials', only: [:destroy]
  end

  # resources :project_materials, only: [:destroy]

  resources :materials do
    get :process_ai, on: :member
    member do
      get :edit_quantity
      get :edit_history
      patch :update_quantity
    end
  end

  resources :questions, only: [:index, :create]
end
