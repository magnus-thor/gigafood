Rails.application.routes.draw do

  get 'home/index'
  root 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :orders, only: [:create, :index]

 end
