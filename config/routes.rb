Rails.application.routes.draw do


  get "/merchants/:id/dashboard", to: "merchant/dashboard#index"
  get "/merchants/:id/items", to: "merchant/items#index"
  get "/merchants/:id/invoices",  to: "merchant/invoices#index"

  # get '/merchants/:id/items', to: 'merchant/items#index'
  get '/merchants/:id/items/new', to: 'merchant/items#new'
  post '/merchants/:id/items', to: 'merchant/items#create'

  get '/admin', to: 'admin#index'

  get '/admin/merchants', to: 'admin/merchants#index'
  post '/admin/merchants', to: 'admin/merchants#create'
  get '/admin/merchants/new', to: 'admin/merchants#new'
  get '/admin/merchants/:merchant_id', to: 'admin/merchants#show'

  get '/admin/invoices', to: 'admin/invoices#index'
  get '/admin/invoices/:invoice_id', to: 'admin/invoices#show'


  get '/merchants/:merchant_id/items/:item_id', to: 'merchant/items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant/items#edit'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant/items#update', as: 'item'
  get '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant/invoices#show'
  patch '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant/invoices#show'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant/items#update'
end
