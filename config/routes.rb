Rails.application.routes.draw do

  get 'charts/index'
  get 'charts/new'

  get 'stocks_data_catchup_crawler/index'
  get 'stocks_data_catchup_crawler/new'
  
end
