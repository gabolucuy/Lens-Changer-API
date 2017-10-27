Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  post 'unsolved_problem/new', to: 'unsolved_problem#create'
  resources :users do
    collection do
    get 'me'
    get 'search'
    end
    resources :children do
      get 'getLaggingSkills' => 'children#getLaggingSkillsOfChild'
      resources "unsolved_problem" do
        get 'getChildConcern', to: 'unsolved_problem#getChildConcerns'
        resources :child_concern do
        end
        get 'myAdultConcerns' => 'unsolved_problem#getMyAdultConcerns'
        resources :adult_concern do
        end
      end
      resources :lagging_skill do
      end
    end
    resources :contacts do
    end
    resources :friends_requests do
      member do
        post 'accept'
        post 'reject'
      end
    end
  end






  #get 'child/:child_id', to: 'children#getChild'
  get 'unsolved_problem/:unsolved_problem_id', to: 'unsolved_problem#getUnsolvedProblem'




end
