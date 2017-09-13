Rails.application.routes.draw do

  get 'home/index'
  root 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :orders, only: [:create, :index, :update] do
    member do
      get 'confirm'
      post 'generate-invoice', action: :generate_invoice
    end

  end

 end
