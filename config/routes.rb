Rails.application.routes.draw do
  root "pages#index"
  get "/about", to: "pages#about"

  namespace :api do
    namespace :v2 do
      resources :boards, only: [:index]
    end
  end

  resources :favorites, only: [:index]

  resources :boards do
    member do
      post :favorite
      put :hide #PUT /boards/2/hide
    end

    resources :posts, shallow: true do
      resources :comments, shallow: true, only: [:create]
    end
  end

  resources :users, only: [:create] do
    collection do
      get :sign_up
      get :edit
      patch :update
      get :sign_in
      post :login
      delete :sign_out
    end
  end
end
