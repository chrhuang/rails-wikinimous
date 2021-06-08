require 'open-uri'

class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    id = params[:id]
    @article = Article.find(id)
    url = "https://pokeapi.co/api/v2/pokemon/#{@article.title.downcase}/"
    @img = JSON.parse(URI.open(url).read)
    @img = @img['sprites']['other']['official-artwork']['front_default']
    # raise
  end

  def new
    @article = Article.new
  end

  def create
    article = Article.create!(article_params)
    redirect_to article_path(article)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to articles_path
  end

  def update
    article = Article.find(params[:id])
    article.update(article_params)
    redirect_to article_path(article)
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
