# coding: utf-8
require 'nokogiri'
require 'open-uri'

def get_content(html, tag, className, index, childPath=nil)
    html.search("//#{tag}[@class='#{className}']#{childPath}")[index].content
end

class StockInfo
    def initialize(stockCode)
        @stockCode = stockCode
        scrape
    end
    attr_reader :stockCode, :price, :openingPrice, :highPrice, :lowPrice, :closingPrice, :volume

    private
    def scrape_stock_info(html, index)
        get_content(html, "dd", "ymuiEditLink mar0", index, "/strong").delete(",")
    end

    def scrape
        begin
            page = open("http://stocks.finance.yahoo.co.jp/stocks/detail/?code=#{@stockCode}")
        rescue OpenURI::HTTPError
            return
        end
        html = Nokogiri::HTML(page.read, nil, 'utf-8')

        @price = get_content(html, "td", "stoksPrice", 0).delete(",")
        @openingPrice = scrape_stock_info(html, 0)
        @highPrice = scrape_stock_info(html, 1)
        @lowPrice = scrape_stock_info(html, 2)
        @closingPrice = scrape_stock_info(html, 3)
        @volume = scrape_stock_info(html, 4)
    end
end

info = StockInfo.new("1413")
puts info.price
puts info.openingPrice
puts info.highPrice
puts info.lowPrice
puts info.closingPrice
puts info.volume