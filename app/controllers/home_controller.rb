require 'news-api'

class HomeController < ApplicationController
  def index
    n = News.new("f8eb522c7f47469d9fc91df0859faeb8")
    @news = n.get_sources(country: 'us', language: 'en')
  end

  def get_news
    n = News.new("f8eb522c7f47469d9fc91df0859faeb8")
    @news = n.get_sources(country: 'us', language: 'en')

    render json: @news
  end
end
