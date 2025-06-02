Rails.application.routes.draw do
  resource :user, only: [ :show, :edit, :update ]

  resources :courses do
    resources :lessons
  end

  resources :enrollments, only: [ :create, :destroy ]

  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"

  get "pages/home"
  get "pages/about"
  get "pages/contacts"

  root "pages#home"

  get "about", to: "pages#about"
  get "contacts", to: "pages#contacts"
  get "my-courses", to: "courses#my_courses"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "logout", to: "sessions#destroy"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # інші коментарі та маршрути
end
