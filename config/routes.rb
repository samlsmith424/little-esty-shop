Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#show'
  get '/admin', to: 'admin#show'
  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/invoices', to: 'admin_invoices#index'
end
