Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'links#index'
  
  resources :links, only: [:create, :new, :index] do
    collection do
      get :best_hundred
    end
  end
  get '/:slug', to: 'links#show', as: :short
end
