Rails.application.routes.draw do

  get 'charts/index'
  get 'charts/new'

  # get 'stocks_data_catchup_crawler/index'
  # get 'stocks_data_catchup_crawler/new'
  resources 'stocks_data_catchup_crawlers', only: [:index, :show, :new, :edit, :create]
  root 'stocks_data_catchup_crawlers#index'
  
end
