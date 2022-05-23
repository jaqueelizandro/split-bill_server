Rails.application.routes.draw do
  resources :groups, :only => [:create, :show] do
    resources :members, :only => [:create]
  end
end
