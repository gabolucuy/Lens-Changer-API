Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  post 'createChild', to: 'childs#create'
  get 'getChild' => 'childs#getChild'
  post 'createLaggingSkill', to: 'lagging_skill#create'
  get 'getLaggingSkill' => 'lagging_skill#getLaggingSkill'
end
