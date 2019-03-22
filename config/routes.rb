Rails.application.routes.draw do
  root to: 'main#index'

  resources :songbooks do
    get 'table_of_contents', on: :member
    get 'blank_page', on: :member
  end

  resources :songs, param: :path
end
