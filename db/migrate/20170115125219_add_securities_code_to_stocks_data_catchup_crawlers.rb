class AddSecuritiesCodeToStocksDataCatchupCrawlers < ActiveRecord::Migration
  def change
    add_column :stocks_data_catchup_crawlers, :securities_code, :integer
  end
end
