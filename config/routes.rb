Rails.application.routes.draw do
  devise_for :users

  resources :videos, path: "/", only: [:index, :new, :create]
end
