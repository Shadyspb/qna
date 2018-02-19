Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    post '/users/auth/sign_up' => 'omniauth_callbacks#sign_up'
  end

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

  namespace :api do
    namespace :v1 do
      resources :profiles, only: :index do
        get :me, on: :collection
      end
    end
  end

  resources :questions, shallow: true, concerns: [:votes, :commented] do
   resources :answers, only: [:create, :destroy, :update], concerns: [:votes,:commented]  do
     post :best_answer, on: :member
   end
  end
end
