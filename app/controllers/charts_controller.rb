class ChartsController < StocksDataCatchupCrawlerController

  def index
    @charts = Chart.all
  end

  def new
    @charts = Chart.new
  end

end
