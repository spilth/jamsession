Rails.application.routes.draw do
  resources :songs, param: :path
end
