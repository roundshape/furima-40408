Rails.application.routes.draw do
  root to: 'items#index'  
  get 'items', to: 'items#index'
end
