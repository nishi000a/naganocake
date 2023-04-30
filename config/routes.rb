Rails.application.routes.draw do
  root 'public/homes#top'

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/admins' => 'homes#top'
    resources :items, only: [:index, :new,:create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end

  post "/items" =>"admin/items#create",as: 'create_item'

  scope module: :public do
    get '/about' => 'homes#about'

    resources :items, only:[:index,:show]

    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :create, :destroy]

    post '/orders/confirm' => 'orders#confirm'
    get  '/orders/complete'=>'orders#complete'
    resources :orders, only:[:new,:create,:index,:show]

    # 退会確認画面
    # get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    # patch '/users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
    
    patch '/customers/withdraw' => 'customers#destroy'
    get '/customers/withdraw' => 'customers#withdraw'
    resource :customers, only:[:show,:edit,:update]


    resources :addresses, only:[:index, :edit, :destroy, :create, :update]
  end


  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

end