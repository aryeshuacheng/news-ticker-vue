class Api::V1::NewsController < ApplicationController

  def get_news
    n = News.new("f8eb522c7f47469d9fc91df0859faeb8")
    @news = n.get_sources(country: 'us', language: 'en')

    render json: @news
  end
end
