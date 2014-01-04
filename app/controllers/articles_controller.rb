# -*- encoding : utf-8 -*-
class ArticlesController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = current_user && current_user.admin? ?
      Article.order("articles.id DESC").paginate(page: params[:page]) :
      Article.published.order("articles.id DESC").paginate(page: params[:page])

    @page_title = '首页'
  end

  def new
    @article = Article.new
    @page_title = '发布文章'

    render layout: "wide"
  end

  def create
    @article = Article.new(article_params)
    
    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def show
    raise ActiveRecord::RecordNotFound if !current_user.try(:admin?) && @article.draft?
    @page_title = "#{@article.title}"
    @page_description = @article.title
  end

  def edit
    @page_title = "#{@article.title}"

    render layout: "wide"
  end

  def update
    if @article.update_attributes(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find params[:id]
    @article.destroy

    redirect_to articles_path
  end

  def tagging
    tag = Tag.find_by_name! params[:tag]
    raise ActiveRecord::RecordNotFound if tag.draft? && !current_user.try(:admin?)

    @articles = tag.articles.order('id DESC').paginate(page: params[:page])
    @page_title = "#{tag.name} 相关文章"
    render :index
  end

  private
    def find_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :tag_list)
    end
end
