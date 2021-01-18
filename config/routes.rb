# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'park/', to: 'park#create'
      delete 'park', to: 'park#destroy'
      get 'park/all', to: 'park#index'
    end
  end
end
