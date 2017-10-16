Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  get 'me', to: 'users#me'




  post 'createAdultConcern', to: 'adult_concern#create'
  get 'getAdultConcern' => 'adult_concern#getAdultConcern'
end
