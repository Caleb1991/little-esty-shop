Rails.application.routes.draw do

  get "/", to: "welcome#index"

  namespace :admin do
    resources :merchants
    resources :invoices
  end

  get '/admin', to: 'admin#index'

  patch '/admin/merchants/:merchant_id/status', to: 'admin/merchants#update_status'

  get "/merchants/:merchant_id/dashboard", to: "merchant/dashboard#index"
  get "/merchants/:merchant_id/items", to: "merchant/items#index"
  get "/merchants/:merchant_id/invoices",  to: "merchant/invoices#index"
  get '/merchants/:merchant_id/items/new', to: 'merchant/items#new'
  post '/merchants/:merchant_id/items', to: 'merchant/items#create'
  get '/merchants/:merchant_id/bulk_discounts', to: 'merchant/bulk_discounts#index'
  get '/merchants/:merchant_id/bulk_discounts/new', to: 'merchant/bulk_discounts#new'
  post '/merchants/:merchant_id/bulk_discounts', to: 'merchant/bulk_discounts#create'
  delete '/merchants/:merchant_id/bulk_discounts', to: 'merchant/bulk_discounts#destroy'

  get '/merchants/:merchant_id/items/:item_id', to: 'merchant/items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant/items#edit'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant/items#update', as: 'item'
  get '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant/invoices#show'
  patch '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant/invoices#update_status'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant/items#update'

  get '/bulk_discounts/:id', to: 'merchant/bulk_discounts#show'
end
