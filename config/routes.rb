Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#show'


  get '/merchants/:id/invoices', to: 'invoices#index'
  get '/merchants/:id/invoices/:id', to: 'invoices#show'

  get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  get '/merchants/:merchant_id/items/new', to: 'merchant_items#new'
  post '/merchants/:merchant_id/items/', to: 'merchant_items#create'
  get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant_items#edit'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#update'

end
