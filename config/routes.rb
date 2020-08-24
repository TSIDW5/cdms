Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'
    
      get '/departments', to: 'departments#index', as: 'list_departments'
      get '/departments/new', to: 'departments#new', as: 'new_department'
      get '/departments/:id', to: 'departments#edit', as: 'edit_department'
      post '/departments', to: 'departments#create', as: 'create_department'
      patch '/departments/:id', to: 'departments#update', as: 'update_department'
      delete '/departments/:id', to: 'departments#destroy', as: 'destroy_department'
    end
  end

  as :admin do
    get 'admins/edit', to: 'admins/registrations#edit', as: 'edit_admin_registration'
    put 'admins/edit', to: 'admins/registrations#update', as: 'admin_registration'
  end
end
