Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :pages, only: [:index]
  resources :doc_lines, only: [:index]
  resources :documents, only: %i[index new show create edit update destroy], shallow: true do
    resources :doc_lines, only: [:show]
  end
end
