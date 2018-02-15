Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
  mount ActionCable.server => '/cable'

  concern :commented do
    member do
      post :comment
    end
  end

  concern :votes do
   member do
     post :vote_up
     post :vote_down
     post :vote_reset
     end
   end

  resources :questions, shallow: true, concerns: [:votes, :commented] do
   resources :answers, only: [:create, :destroy, :update], concerns: [:votes,:commented]  do
     post :best_answer, on: :member
   end
  end
end
