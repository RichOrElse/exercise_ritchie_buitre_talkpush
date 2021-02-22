Rails.application.routes.draw do
  resources :candidates, only: :index do
    post :check, on: :collection
  end

  root to: 'candidates#index'
end
