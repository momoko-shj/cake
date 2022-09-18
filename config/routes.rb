Rails.application.routes.draw do
  
  devise_for :customers,skip: [:passwords],controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  
  devise_for :admin, skip:[:registrations, :passwords] ,controllers: {
  registrations: "admin/registrations",
  sessions: "admin/sessions"
  }
  
  get "about"=>"public/homes#about",as:"about"
  get "customerindex"=>"admin/orders#customerindex",as:"customerindex"
  get 'searches/search', to: 'searches#search'
  
  namespace :admin do
    root to: 'homes#top'
    resources :customers, only:[:show,:edit,:index,:update]
    resources :genres, only:[:index,:edit,:create,:update,:destroy]
    resources :homes, only:[:top]
    resources :items, only:[:index,:edit,:create,:update,:show,:new,:destroy]
    resources :orders ,only:[:update,:show,:index]
    resources :order_details, only:[:update]
  end
  
  
  scope module: :public do
    root to:"homes#top"
      resources :customers,only:[:edit,:update,:show] do
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
      post 'orders/comfirm' => 'orders#comfirm',as:"comfirm"
      get 'orders/thanks' => 'orders#thanks',as:"thanks"
        resources :orders, only:[:index,:create,:show,:new] do
        end
      resources :items, only:[:index,:show]
      resources :addresses, only:[:index,:edit,:create,:update,:destroy]
    end
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
