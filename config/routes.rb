Rails.application.routes.draw do
  
  namespace :admin do
    root to: 'homes#top'
    resources :customers, only:[:show,:edit,:index,:update]
    resources :genres, only:[:index,:edit,:create,:update]
    resources :homes, only:[:top]
    resources :items, only:[:index,:edit,:create,:update,:show,:new]
    resources :orders ,only:[:update,:show]
    resource :order_details, only:[:update]
    end
  
  root to:'public/homes#top'
  get "about"=>"public/homes#about",as:"about"
  
  # get 'customers/unsubscript' => 'public/customers#unsubscript',as:"unsubscript"
  # patch 'customers/withdraw' => 'public/customers#withdraw',as:"withdraw"
  # get 'orders/thanks' => 'public/orders#thanks',as:"thanks"
  # post 'orders/comfirm' => 'public/orders#comfirm',as:"comfirm"
  # delete 'cart_items/destroy_all' => 'public/cart_items#destroy_all',as:"destroy_all"

  scope module: :public do
    resources :customers,only:[:show,:edit,:update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    resources :cart_items, only:[:index,:create,:update,:destroy] do
      collection do
        delete 'destroy_all'
      end
     end
    resources :orders, only:[:index,:create,:show,:new] do
     collection do
        get 'thanks'
        post 'comfirm'
     end
    end
    resources :items, only:[:index,:show]
    resources :addresses, only:[:index,:edit,:create,:update,:destroy]
  end

  
  
  devise_for :customers,skip: [:passwords],controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  
  devise_for :admin, skip:[:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
