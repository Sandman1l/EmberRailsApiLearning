# frozen_string_literal: true

Rails.application.routes.draw do
  resources :authors do
    resources :books
  end
  resources :books
  resources :publishing_houses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
