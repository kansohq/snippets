Rails.application.routes.draw do
  mount Snippets::Engine => "/snippets"

  get 'test' => 'test#index', as: :test

  root to: 'application#home'
end
