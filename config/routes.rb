Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'ping' => 'api#ping'
      get 'utc' => 'api#utc'
      resources :users, only: [:create] do
        collection do
          post :signin
        end
      end

      resources :hotels, only: [:index, :show] do
        member do
          get :availability
        end
      end
    end
  end
end
