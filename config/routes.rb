Rails.application.routes.draw do
  
  

  #devise_for :utentis
  devise_for :utentis, :path_prefix => 'my'#, :skip => [:registrations]
  #as :utentis do
  #  get 'utentis/edit' => 'devise/registrations#edit'#, :as => 'edit_utenti_registration'    
  #  put 'utentis' => 'devise/registrations#update'#, :as => 'utenti_registration'            
  #end
  resources :utentis

  ###################

  ###################


  root to: "welcome#index"
  #root 'welcome#index'
  get 'welcome/aperti', :path => "aperti"
  get 'welcome/prelogin'
  get 'welcome/justone'
  post 'welcome/justone'
  get 'welcome/login', :path => 'login'
  get 'welcome/login'
  get 'welcome/assegnati', :path => 'assegnati'
  get 'welcome/elenco', :path => 'elenco'
  get 'welcome/richiedi', :path => 'richiedi'
  post 'welcome/richiesta'
  #post 'interventi/sms'
  



  resources :clienti do
    #devise_for :utentis
    resources :contrattis
    resources :interventi do
      
      get :sms
      get :allega
      get :vediallegato
      patch :salva_allegato
      get :elimina_allegato
        resources :intallegatis
        resources :comunicazioni
        resources :works do
          get :allega
          patch :salva_allegato
          get :elimina_allegato
          get :vedi_allegato
        end
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
