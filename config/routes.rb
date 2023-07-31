Rails.application.routes.draw do
  root 'prompts#index'

  resources :prompts do
    post 'search', on: :collection
  end
end
