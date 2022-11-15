Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'tourist_sights/index'
    end
  end
  namespace :api do
    namespace :v1 do
      resources :recipes, only: :index
      resources :learning_resources, only: :index
      resources :users, only: :create
      resources :favorites, only: %i[create index]
      resource :favorites, only: :destroy
      resources :tourist_sights, only: :index
      resources :sessions
    end
  end
end
