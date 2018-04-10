Rails.application.routes.draw do
  get 'welcome/index'

  resources :invoices

  root 'invoices#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
