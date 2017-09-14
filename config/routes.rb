Rails.application.routes.draw do

  root 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :orders, only: [:create, :index, :update] do
    member do
      get 'confirm'
      put 'generate-invoice', action: :generate_invoice
    end
  end
 end
