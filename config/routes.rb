Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
  resources :questions, shallow: true do
    resources :answers, only: %i[destroy create update] do
      post :best_answer, on: :member
    end
  end
end
