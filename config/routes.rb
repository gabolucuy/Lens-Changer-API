Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  resources :users do
    resources :children do
        get 'getLaggingSkills' => 'children#getLaggingSkillsOfChild'
        resources :lagging_skill do
        end
    end
  end

    # post 'createAdultConcern', to: 'adult_concern#create'
    # get 'getAdultConcern' => 'adult_concern#getAdultConcern'
    # post 'createLaggingSkill', to: 'lagging_skill#create'



  get 'me', to: 'users#me'






end
