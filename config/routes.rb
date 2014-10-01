Rails.application.routes.draw do
  get '/users/auth/:service/callback' => 'user_services#create'
  devise_for :users

  get '/users/auth/:service/callback' => 'user_services#create'
  # resources :user_services, :only => [:create]

  get 'gems' => 'projects#gems', as: :gems
  get 'apps' => 'projects#apps', as: :apps
  get '/new' => 'projects#new', as: :new_project
  resources :projects, path: '/' do
    get '/*full_name/edit' => 'projects#edit', on: :collection, as: :edit
    get '/*full_name' => 'projects#show', on: :collection, as: :show
  end
end
