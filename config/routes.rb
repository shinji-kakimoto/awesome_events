Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/destroy' => 'sessions#destroy', as: :logout
end
