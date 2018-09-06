Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   root 'client/home#index'
  #   # 客户端相关路由
  namespace :client do
  	root 'home#index', as: 'root'
  	resources :home, only: [:index]
  	resources :articles, only: [:index]
  	resources :about, only: [:index]
    resources :archives, only: [:index]
    # resources :comments, except: [:destroy, :index, :show]
    resources :comments, only: [:create, :index]
    resources :articles do 
      collection do
        get 'by_tag'
      end
    end
  end

  namespace :admin do
    root 'dashboard#index', as: 'root'
    resources :dashboard, only: [:index]
    resources :articles
    resources :comments

    # resources :articles do
    #   member do
    #     # 成员路由
    #   end

    #   collection do
    #     # 集合路由
    #   end

    # end
    post 'articles/preview'
  end
end
