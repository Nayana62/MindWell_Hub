Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, only: [:create, :destroy]
    member do
      post 'like'
      delete 'unlike'
    end
  end
  root 'home#index'
end
