Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  resources :users do
    resources :children do      
    end
  end
  get 'me', to: 'users#me'

end
