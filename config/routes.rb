Rails.application.routes.draw do
require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'

  root 'static_pages#home'
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: 'passwords' }
  get "sign_up", to: redirect("/")
  get "users/sign_up", to: redirect("/")

  get "/commande", to: "leads#new"
  resources :leads, only: [:create, :new] do
    collection do
      get "/sent", to: "leads#sent"
    end
  end
  namespace :gardien do
    resources :messages
    resources :buildings do
      resources :channels
    end
    scope "immeubles" do
      get "/:slug(/:channel)", to: "buildings#show", as: :appartments
    end
    get "/notify_message", to: "messages#notify_message"
    get "/notify_colis", to: "messages#notify_colis"
    post "/notify_buildings", to: "messages#notify_buildings"
    post "/notify_users", to: "messages#notify_users"
  end
  post "messages/new_photo", to: "messages#new_photo"
  namespace :admin do
    resources :stats
    resources :buildings
    resources :messages
    resources :users
    get "/notifier", to: "messages#notifier"
    post "/notify_buildings", to: "messages#notify_buildings"
  end
  resources :buildings do
    resources :channels
  end
  resources :comments

  scope "immeubles" do
    get "/:slug(/:channel)", to: "buildings#show", as: :appartments
  end

  resources :messages do
    post "add_like", to: "messages#add_like"
    post "remove_like", to: "messages#remove_like"
  end

  Rails.application.routes.url_helpers.module_eval do
    def building_path(building)
      building_path + "/#{building.slug}"
    end

  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
