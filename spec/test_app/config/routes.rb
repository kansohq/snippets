Rails.application.routes.draw do

  mount Snippets::Engine => "/snippets"
end
