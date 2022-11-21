Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      get 'get_news', to: 'news#get_news'
      get 'get_sources', to: 'news#get_sources'
      get 'get_countries', to: 'news#get_countries'
      get 'save_query', to: 'news#save_query'
      get 'delete_query', to: 'news#delete_query'
      get 'get_saved_queries', to: 'news#get_saved_queries'
      get 'add_folder', to: 'news#add_folder'
      get 'get_folders', to: 'news#get_folders'
      get 'load_queries_from_folder', to: 'news#load_queries_from_folder'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

