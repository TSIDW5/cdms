Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'

      concern :paginatable do
        get '(page/:page)', action: :index, on: :collection, as: ''
      end
      concern :searchable_paginatable do
        get '/search/(:term)/(page/:page)', action: :index, on: :collection, as: :search
      end

      resources :users, constraints: { id: /[0-9]+/ }, concerns: [:paginatable, :searchable_paginatable]
      resources :administrators, only: [:index, :create, :destroy]
      get '/administrators/search/(:term)', to: 'administrators#search_non_admins',
                                            as: 'search_non_administrators'

      resources :audience_members, constraints: { id: /[0-9]+/ }, concerns: [:paginatable, :searchable_paginatable]

      resources :departments, constraints: { id: /[0-9]+/ }, concerns: [:paginatable, :searchable_paginatable] do
        resources :department_modules, except: [:index, :show], as: :modules, path: 'modules'

        get '/members', to: 'departments#members', as: :members
        get '/non-members/search/(:term)', costraints: { term: %r{[^/]+} }, # allows anything except a slash.
                                           to: 'departments#non_members',
                                           as: 'search_non_members'

        post '/members', to: 'departments#add_member', as: :add_member
        delete '/members/:id', to: 'departments#remove_member', as: 'remove_member'
      end
    end
  end

  as :admin do
    get 'admins/edit', to: 'admins/registrations#edit', as: 'edit_admin_registration'
    put 'admins/edit', to: 'admins/registrations#update', as: 'admin_registration'
  end
end
