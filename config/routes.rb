Rails.application.routes.draw do
  apipie
  mount SabisuRails::Engine => "/sabisu_rails"
  # devise_for :users
  # Api definition
  namespace :api ,path: '/'do
    scope module: :v1 ,:defaults => { :format => 'json' } do
    # We are going to list our resources here
      resources :users ,:only =>[:create,:update,:destroy,:show]
      resources :sessions, :only => [:create, :destroy]
    end
  end
end
