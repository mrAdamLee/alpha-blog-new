class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :edit, :destroy]
  def show
  end

  def index
    @articles = Article.all
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article has been successfully updated."
      redirect_to @article
    else 
      render :edit, status: 422
    end
  end

  def edit 
  end

  def new 
    @article = Article.new #<--initiate an article with nothing in it so we can check for validation errors and flash them on view
  end

  def destroy
    #TODO: do this with a partial and turbolinks/streams, ie dont redirect the user.
    if @article.destroy
      flash[:notice] = "Article deleted successfully"
      redirect_to articles_path
    end
  end

  def create 
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was created succesfully."
      redirect_to @article #<--extracts id and redirects to articles/:id
    else 
      render :new, status: 422 #<-- turbo expecting redirect, cant have 200 and not reload, this makes it so we dont reload but gets status
    end

  end


  private 

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
