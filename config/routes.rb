Rails.application.routes.draw do
  devise_for :users

  root to: "pages#landing_page"
  get "/home", to: "pages#home"
  get "/sign_in", to: "sessions#new"
  get "/sign_up", to: "users#new"
  delete "/users/sign_out", to: "sessions#destroy"

  resources :projects do
    resources :project_materials, only: [:new, :create]
  end

  resources :materials
end
