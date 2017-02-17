class StocksDataCatchupCrawlersController < ApplicationController

  def index
    @stocks_data_catchup_crawlers = StocksDataCatchupCrawler.all
  end

  def show
    @stocks_data_catchup_crawler = StocksDataCatchupCrawler.find(params[:id])
  end

  def new
    @stocks_data_catchup_crawler = StocksDataCatchupCrawler.new
    # @stocks_data_catchup_crawler.qwerty
  end

  def create
    security_code = params[:stocks_data_catchup_crawler][:securities_code]
    # logger.debug "==----------#{security_code}--------"
    get_datas = StocksDataCatchupCrawler.qwerty(security_code)
    
    get_datas.each do |day, open_price, hight_price, low_price, closing_price, volume|
      stocks_data_catchup_crawler = StocksDataCatchupCrawler.new
      stocks_data_catchup_crawler.securities_code = security_code
      stocks_data_catchup_crawler.day = day
      stocks_data_catchup_crawler.open_price = open_price
      stocks_data_catchup_crawler.hight_price = hight_price
      stocks_data_catchup_crawler.low_price = low_price
      stocks_data_catchup_crawler.closing_price = closing_price
      stocks_data_catchup_crawler.volume = volume

      stocks_data_catchup_crawler.save
    end
    redirect_to root_path
  end

end
