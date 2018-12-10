Rails.application.routes.draw do
  devise_for :users
  get 'admin/index'
  root 'page#index'
  get '/nosotros', to: 'page#nosotros', as: 'nosotros'
  get '/simbolos', to: 'page#simbolos', as: 'simbolos'
  get '/galeria', to: 'page#galeria', as: 'galeria'
  get '/contacto', to: 'page#contacto', as: 'contacto'
  get 'padres/index'
  resources "padres"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
