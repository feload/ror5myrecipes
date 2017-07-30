Rails.application.routes.draw do
  
  root 'pages#home'
  
  get 'pages/home',       to: 'pages#home'
  
  get 'login',            to: 'sessions#new'
  post 'login',           to: 'sessions#create'
  get 'logout',           to: 'sessions#destroy'
  
  resources :recipes
  resources :chefs
  
end
