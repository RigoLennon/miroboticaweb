class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show,:index,:exam]
  before_action :set_article, except: [:index,:new,:create]
  before_action :authenticate_teacher!, only: [:new, :create,:update]
  before_action :authenticate_admin!, only:[:new,:create,:update,:destroy]


  def index
    #Añadimos todos los registros a la vista
    @articles = Article.all
  end



  def show
    @article.update_visits_count
  end

  def new
    @article = Article.new
    @categories = Category.all
  end



  def edit
  end


  def create
    @article = current_user.articles.new(article_params)
    @article.categories = params[:categories]

    if @article.save
      redirect_to @article
    else
      render :new
    end

  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy  #Destroy elimina el objeto de la base de datos
    redirect_to articles_path
  end


  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end


  private

  def set_article
    @article = Article.find(params[:id])
  end


  def validate_user
    redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
  end


  def article_params
    params.require(:article).permit(:title,:body,:objectives,:finishactivity,:goals,:requirements,:image,:imagefritzing,:imagematerials,:categories,:youtubeurl,:form,:imagearduino)
  end

end