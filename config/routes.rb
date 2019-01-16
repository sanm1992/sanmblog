Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   root 'client/home#index'
  #   # 客户端相关路由
  namespace :client do
  	root 'home#index', as: 'root'
  	resources :home, only: [:index]
  	resources :about, only: [:index]
    resources :archives, only: [:index]
    # resources :comments, except: [:destroy, :index, :show]
    resources :comments, only: [:create, :index]
    resources :photos, only: [:index]
    resources :articles, only: [:index, :show] do 
      collection do
        get 'by_tag'
      end
    end
  end

  namespace :admin do
    root 'dashboard#index', as: 'root'
    resources :dashboard, only: [:index]
    # resources :articles
    resources :comments, only: [:index, :destroy] do
      collection do
        get 'message_list'
      end
    end
    resources :users do
      member do
        post 'set_enabled'
      end
    end

    resources :articles do
      member do
        # 成员路由
        post 'set_enabled'
      end
    end

    #   collection do
    #     # 集合路由
    #   end

    # end
    post 'articles/preview'

    resources :photos do
      delete 'delete'
      post 'set_enabled'
    end

    resources :article_tags do
      post 'set_enabled'
    end

  end

  get     'login'     => 'admin/sessions#new'
  post    'login'     => 'admin/sessions#create'
  delete  'logout'    => 'admin/sessions#destroy'
  get     'register'  => 'admin/users#new'
  post    'register'  => 'admin/users#create'
  post    'reset'     => 'admin/users#reset_password'

  match "/404", :to => "errors#client_error", :via => :all
  match "/500", :to => "errors#server_error", :via => :all

end
