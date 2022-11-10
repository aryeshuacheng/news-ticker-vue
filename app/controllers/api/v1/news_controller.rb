class Api::V1::NewsController < ApplicationController
  before_action :initiate_api

  def initiate_api
    @news_connection = News.new("f8eb522c7f47469d9fc91df0859faeb8")
  end

  def get_news
    if params[:sources].nil?
      @news = JSON.parse(Excon.get('https://newsapi.org/v2/everything?q=' + params[:query] +'&apiKey=f8eb522c7f47469d9fc91df0859faeb8').body)['articles']
    else
      @news = JSON.parse(Excon.get('https://newsapi.org/v2/everything?q=' + params[:query] +'&apiKey=f8eb522c7f47469d9fc91df0859faeb8'+'&source=' + params[:sources]).body)['articles']
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

  def save_query
    Query.create(name: params[:query])
  end

  def get_saved_queries
    @queries = Query.all

    render json: @queries
  end
end
