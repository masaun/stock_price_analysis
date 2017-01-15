class StocksDataCatchupCrawlerController < ApplicationController

  def new
    @stocks_data_catchup_crawler = Stocks_data_catchup_crawler.new
  end

  def create
    @stocks_data_catchup_crawler = Stocks_data_catchup_crawler.find(params[:id])
    stocks_data_catchup_crawler.save
  end

end
