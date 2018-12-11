Rails.application.routes.draw do
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new"
    #get "/sign_up" => "devise/registrations#new", as: "new_user_registration"
  end
  devise_for :users, :skip => [:registrations] 
  as :user do
  get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
  put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  root 'page#index'
  get '/nosotros', to: 'page#nosotros', as: 'nosotros'
  get '/simbolos', to: 'page#simbolos', as: 'simbolos'
  get '/galeria', to: 'photos#galeria', as: 'galeria'
  get '/contacto', to: 'page#contacto', as: 'contacto'
  get '/admin', to: 'admins#index', as: 'admin'
  get '/publicaciones', to: 'admins#publicaciones', as: 'publicaciones'
  get '/padres/infoutil', to: 'padres#infoutil'
  get '/padres/boletines', to: 'padres#boletines'
  resources "padres"
  resources "photos", :only => [:create, :destroy]
  resources "admins", :only => [:edit]
  patch '/admin.:id', to: 'admins#update'
end
