Rails.application.routes.draw do
  devise_for :users
  root to: 'documents#index'
  get '/doc_lines_2', to: 'doc_lines#index_ajax'
  get '/doc_lines_3', to:'doc_lines#index_ajax_3', as: :coco
  resources :pages, only: [:index]
  resources :doc_lines, only: [:index]
  resources :documents, only: %i[index new show create edit update destroy], shallow: true do
    resources :doc_lines, only: [:show]
  end

end
