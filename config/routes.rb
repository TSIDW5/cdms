Rails.application.routes.draw do

  root to: 'home#index'

  devise_for :audience_members, :controllers => {:registrations => "audience_members/registrations"}
  authenticate :audience_member do
    namespace :audience_members do
      root to: 'dashboard#index'
    end
  end

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'
      resources :users
      resources :audience_members
      post 'audience_members/import', to: 'audience_members#import', as: 'audience_members_import' 
      resources :departments do
        resources :department_modules, except: [:index, :show], as: :modules, path: 'modules'
      end
    end
  end

  as :admin do
    get 'admins/edit', to: 'admins/registrations#edit', as: 'edit_admin_registration'
    put 'admins/edit', to: 'admins/registrations#update', as: 'admin_registration'
  end
end
