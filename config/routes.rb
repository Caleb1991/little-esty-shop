Rails.application.routes.draw do

  get "/", to: "welcome#index"

  get "/merchants/:id/dashboard", to: "merchant/dashboard#index"
  get "/merchants/:id/items", to: "merchant/items#index"
  get "/merchants/:id/invoices",  to: "merchant/invoices#index"

  get '/merchants/:id/items/new', to: 'merchant/items#new'
  post '/merchants/:id/items', to: 'merchant/items#create'

  get '/admin', to: 'admin#index'

  get '/admin/merchants', to: 'admin/merchants#index'
  post '/admin/merchants', to: 'admin/merchants#create'
  get '/admin/merchants/new', to: 'admin/merchants#new'
  get '/admin/merchants/:merchant_id', to: 'admin/merchants#show'
  patch '/admin/merchants/:merchant_id/status', to: 'admin/merchants#update_status'
  get '/admin/merchants/:merchant_id/edit', to: 'admin/merchants#edit'
  patch "/admin/merchants/:merchant_id", to: 'admin/merchants#update'


  get '/admin/invoices', to: 'admin/invoices#index'
  get '/admin/invoices/:invoice_id', to: 'admin/invoices#show'
  patch '/admin/invoices/:invoice_id', to: 'admin/invoices#update'

  get '/merchants/:merchant_id/items/:item_id', to: 'merchant/items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant/items#edit'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant/items#update', as: 'item'
  get '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant/invoices#show'
  patch '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant/invoices#update_status'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant/items#update'
end
