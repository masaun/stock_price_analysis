class YahoosController < ApplicationController

  require 'open-uri'
  require 'nokogiri'

  def index
    @yahoos = Yahoo.all
  end

  def new
    @yahoo = Yahoo.new
  end

  def create
    url = 'http://www.yahoo.co.jp/'
    charset = nil
    html = open(url) do |f|
    charset = f.charset # 文字種別を取得
    f.read # htmlを読み込んで変数htmlに渡す
  end

  doc = Nokogiri::HTML.parse(html, nil, charset)
    Yahoo.create(content: doc)
    redirect_to yahoos_path
  end

end
