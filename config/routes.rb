Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  resources :users do
    resources :children do      
    end
    post 'createAdultConcern', to: 'adult_concern#create'
    get 'getAdultConcern' => 'adult_concern#getAdultConcern'
    post 'createLaggingSkill', to: 'lagging_skill#create'
    get 'getLaggingSkill' => 'lagging_skill#getLaggingSkill'
  end
  

  get 'me', to: 'users#me'




  

end
