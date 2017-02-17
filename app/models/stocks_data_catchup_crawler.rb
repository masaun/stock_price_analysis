class StocksDataCatchupCrawler < ActiveRecord::Base

  # _*_ coding: utf-8 _*_
  require 'nokogiri'
  require 'open-uri'

class << self

  def get_nokogiri_doc(url)
    begin
      html = open(url)
    rescue OpenURI::HTTPError
      return
    end
    Nokogiri::HTML(html.read, nil, 'utf-8')
  end

  def has_next_page?(doc)
    doc.xpath("//*[@id='main']/ul/a").each {|element|
      return false if element.text == "次へ"
      # logger.debug "---------#{element.text}----"
    }
  end

  def get_daily_data(doc)
    days = []
    open_prices = []
    hight_prices = []
    low_prices = []
    closing_prices = []
    volumes = []
    # num = 0

    doc.xpath("//table[@class='boardFin yjSt marB6']/tr").each {|element|

      if element.children[0].text !=
        "日付" && element.children[1][:class] != "through"

        # 日付
        days << element.children[0].text

        # 始値
        open_prices << element.children[1].text.gsub(",", "").to_i

        # 高値
        hight_prices << element.children[2].text.gsub(",", "").to_i

        # 安値
        low_prices << element.children[3].text.gsub(",", "").to_i

        # 終値
        closing_prices << element.children[4].text.gsub(",", "").to_i

        # 出来高
        volumes << element.children[5].text.gsub(/,/,'').to_i

        # puts "#{days[num]}, #{open_prices[num]}, #{hight_prices[num]}, #{low_prices[num]}, #{closing_prices[num]}, #{volumes[num]}"
        # num = num + 1

      end
    }
    all_datas = days.zip(open_prices, hight_prices, low_prices, closing_prices, volumes)
    # p all_datas
    return  all_datas
  end

  def qwerty(code)
  # 検索したい証券コード（下記はトヨタ自動車の証券コード。一旦、実数でテストを行い、正常に挙動することを確認でき次第、変数に置き換える）
  # code = "7203"
  # code = hoge

  # 検索日
  day = Time.now
  ey = day.year
  em = day.month
  ed = day.day
  data = ""
  start_url = "http://info.finance.yahoo.co.jp/history/?sy=1900&sm=1&sd=1&ey=#{ey}&em=#{em}&ed=#{ed}&tm=d&code=#{code}"
  logger.debug "=-----------------#{start_url}------"
  num = 1
  puts "日付, 始値, 高値, 安値, 終値, 出来高"
  loop {
    url = "#{start_url}&p=num"
    doc = get_nokogiri_doc(url)
    data = get_daily_data(doc)
    break if !has_next_page?(doc)
    num = num + 1
  }
  return data
  end
end

end