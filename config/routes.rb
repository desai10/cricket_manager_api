Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post 'teams/:id/add_user/:user_id' => 'teams#add_user'
      post 'teams/:id/add_users' => 'teams#add_users'
      delete 'users/:id/leave_team/:team_id' => 'users#leave_team'
      delete 'teams/:id/remove_user/:user_id' => 'teams#remove_user'
      resources :users
      resources :teams
    end
  end
end
