Rails.application.routes.draw do
  resources :groups, only: [:create, :show] do
    resources :members, only: [:create, :index, :update, :destroy]
    post '/inicialmembers', to: 'members#create'
    resources :transactions, only: [:create, :index, :update, :destroy]
    resources :debts, only: [:index]
    resources :settle, only: [:create]
  end
end
