Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'ping' => 'api#ping'
      get 'utc' => 'api#utc'
      resources :users, only: [:create] do
        collection do
          post :sign_in
        end
      end
    end
  end
end
