Rails.application.routes.draw do
  resources :candidates, only: :index do
    post :import, on: :collection
  end

  root to: 'candidates#index'
end
