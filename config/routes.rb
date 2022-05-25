Rails.application.routes.draw do
  resources :groups, only: [:create, :show] do
    resources :members, only: [:create, :index]
    post '/inicialmembers', to: 'members#create'
    resources :transactions, only: [:create, :index]
    resources :debts, only: [:index]
  end
end
