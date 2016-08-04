Rails.application.routes.draw do

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:show, :create, :edit, :update, :destroy] do
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:show, :create, :edit, :update, :destroy]

  resources :users, only: [:create, :new, :show]

  resources :sessions, only: [:create, :new, :destroy]

  resources :notes, only: [:create, :destroy]

  root to: 'sessions#new'

end
