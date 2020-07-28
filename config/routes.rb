# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :grocery_list do
    resource :list, controller: :list, only: [:show] do
      post :add_item, on: :member, as: :add_item
      post :remove_item, on: :member, as: :remove_item
      post :buy_item, on: :member, as: :buy_item
      post :clear_list, on: :member, as: :clear_list
    end
    resources :categories, only: [:index] do
      resources :products, only: [:index], module: :categories
    end
  end
end
