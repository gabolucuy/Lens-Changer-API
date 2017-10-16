Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  post 'createChild', to: 'childs#create'
  get 'getChild' => 'childs#getChild'
  
  get 'me', to: 'users#me'

end
