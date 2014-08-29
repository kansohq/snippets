Snippets::Engine.routes.draw do
  resources :snippets do
    collection do
      get :search
    end
  end

  root to: 'snippets#index'
end
