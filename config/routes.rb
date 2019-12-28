Rails.application.routes.draw do
  root 'sessions#new'
  get 'sessions/new'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
