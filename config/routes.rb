Rails.application.routes.draw do
  root to: 'main#index'
  resources :songbooks do
    get 'table_of_contents', on: :member
  end
  resources :songs, param: :path
end
