Rails.application.routes.draw do
  devise_for :users
  root to: "pages#landing_page"
  get "/sign_in", to: "sessions#new"
  get "/sign_up", to: "users#new"

  resources :projects do
    resources :project_materials, only: [:new, :create]
  end

  resources :materials
end
