class CreateStocksDataCatchupCrawlers < ActiveRecord::Migration
  def change
    create_table :stocks_data_catchup_crawlers do |t|
      t.date :day
      t.integer :open_price
      t.integer :hight_price
      t.integer :low_price
      t.integer :closing_price
      t.integer :volume

      t.timestamps null: false
    end
  end
end
