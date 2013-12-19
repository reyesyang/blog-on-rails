# -*- encoding : utf-8 -*-
class ArticlesController < ApplicationController
  before_filter :require_admin, only: [:new, :create, :edit, :update, :destroy]
  before_filter :load_article_with_tags, only: [:show, :edit]

  def index
    @articles = current_user && current_user.admin? ?
      Article.includes(:tags).order("articles.id DESC").paginate(:page => params[:page]) :
      Article.includes(:tags).where("tags.name != 'draft'").order("articles.id DESC").paginate(:page => params[:page])

    @page_title = '首页'

    respond_to do |format|
      format.html
    end
  end

  def show
    @page_title = '文章 - ' + @article.title
    @page_description = @article.title

    respond_to do |format|
      format.html
    end
  end

  def new
    @article = Article.new
    @page_title = '发布文章'

    respond_to do |format|
      format.html { render layout: 'wide' }
    end
  end

  def edit
    @page_title = '编辑文章 - ' + @article.title
    render layout: 'wide'
  end

  def create
    @article = Article.new(article_params)
    
    respond_to do |format|
      if @article.save
        format.html { redirect_to(@article, :notice => 'Article was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @article = Article.find params[:id]
    respond_to do |format|
      if @article.update_attributes(article_params)
        format.html { redirect_to(@article, :notice => 'Article was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @article = Article.find params[:id]
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

  def tagging
    tag = Tag.find_by_name! params[:tag]
    @articles = tag.articles.includes(:tags).paginate(page: params[:page])
    render :index
  end

  private
    def load_article_with_tags
      @article = Article.includes(:tags).find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :tag_list)
    end
end
