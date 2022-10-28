class Api::V1::NewsController < ApplicationController
  before_action :initiate_api

  def initiate_api
    @news_connection = News.new("f8eb522c7f47469d9fc91df0859faeb8")
  end

  def get_news
    if params[:sources].nil?
      @news = @news_connection.get_top_headlines(q: params[:query])
      puts "hey"
    else
      @news = @news_connection.get_top_headlines(q: params[:query], sources: params[:sources])
      puts "source present"
    end

    render json: @news
  end

  def get_sources
    @news = @news_connection.get_sources(country: 'us', language: 'en')

    render json: @news
  end

  def get_countries
    @countries = Excon.get('http://api.worldbank.org/v2/country')
    render json: @countries
  end
end
