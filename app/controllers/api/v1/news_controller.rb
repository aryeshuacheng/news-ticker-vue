class Api::V1::NewsController < ApplicationController

  def get_news
    if params[:sources].nil?
      @news = JSON.parse(Excon.get('https://newsapi.org/v2/everything?q=' + params[:query] +'&apiKey=cbc61efe17a143ae83fbb8fd3d5037ff').body)['articles']
    else
      @news = JSON.parse(Excon.get('https://newsapi.org/v2/everything?q=' + params[:query] +'&apiKey=cbc61efe17a143ae83fbb8fd3d5037ff'+'&source=' + params[:sources]).body)['articles']
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
    folder = Folder.find_by(name: params[:folder_name], user_id: current_user.id)

    Query.create(user_id: current_user.id, name: params[:query], folder_id: folder.id)
  end

  def delete_query
    Query.where(user_id: current_user.id, name: params[:query]).destroy_all
  end

  def get_saved_queries
    folder = Folder.find_by(name: params[:folder_name], user_id: current_user.id)

    @queries = Query.where(user_id: current_user.id, folder_id: folder.id)

    render json: @queries
  end

  def add_folder
    Folder.create(user_id: current_user.id, name: params[:name])
  end

  def get_folders
    @folders = Folder.where(user_id: current_user.id)

    render json: @folders
  end

  def load_queries_from_folder
    folder = Folder.find_by(name: params[:folder_name], user_id: current_user.id)
    queries = Query.where(user_id: current_user.id, folder_id: folder.id)

    render json: queries
  end
end
