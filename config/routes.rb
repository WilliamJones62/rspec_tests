Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # Original routes
  resources :battles
  resources :monsters do
    collection do
      post :import
    end
  end

  # Editable routes
  root "monsters_extended#index"
  resources :battles_extended
  resources :monsters_extended do
    collection do
      post :import
    end
  end
end
