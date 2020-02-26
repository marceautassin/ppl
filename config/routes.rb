Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :pages, only: [:index]
  resources :documents, only: %i[index new show create destroy], shallow: true do
    resources :doc_lines, only: [:index :new :create]
  end
end
