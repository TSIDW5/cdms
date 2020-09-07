Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'
      resources :users do
        get '/search', to: 'users#search', as: 'search', on: :collection
      end
      resources :audience_members
      resources :departments do
        get '/users', to: 'departments#users', as: 'users_list'
        post '/user', to: 'departments#add_user', as: 'user_create'
        delete '/users/:user_id', to: 'departments#destroy_user', as: 'users_destroy'

        resources :department_modules, except: [:index, :show], as: :modules, path: 'modules' do
          get '/users', to: 'department_modules#users', as: 'users_list'
          post '/user', to: 'department_modules#add_user', as: 'user_create'
          delete '/users/:user_id', to: 'department_modules#destroy_user', as: 'users_destroy'
        end
      end
    end
  end

  as :admin do
    get 'admins/edit', to: 'admins/registrations#edit', as: 'edit_admin_registration'
    put 'admins/edit', to: 'admins/registrations#update', as: 'admin_registration'
  end
end
