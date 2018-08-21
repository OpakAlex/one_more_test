Rails.application.routes.draw do
  devise_for :users
  namespace :api, constraints: {format: 'json'} do
    namespace :v1 do
      resources :trailers, only: %i[index show] do
        member do
          get :download
        end
      end
    end
  end
end
