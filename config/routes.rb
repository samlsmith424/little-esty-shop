Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'application#welcome'

  get '/merchants/:id/dashboard', to: 'merchants#show'

  resources :merchants, only: [] do
    resources :invoices, only: %i[index show update]
    resources :merchant_items, only: %i[index new show create edit update]
    resources :bulk_discounts, only: %i[index show new]
  end

  namespace :admin do
    resources :merchants, only: %i[index show edit update new create]
    resources :invoices, only: %i[index show update]
    resources :dashboard, only: [:index]
  end

  resources :github_api, only: [:index]

  post "/merchants/:id/bulk_discounts/new", to: "bulk_discounts#create"
end
