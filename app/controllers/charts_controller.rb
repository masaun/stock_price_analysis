class ChartsController < NokogiriStocksController

  def index
    @charts = Chart.all
  end

  def new
    @chart = Chart.new
  end

end
