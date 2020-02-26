Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :pages, only: [:index]
  resources :documents, only: %i[index new show create edit update destroy], shallow: true
  resources :doc_lines, only: [:index]
end
