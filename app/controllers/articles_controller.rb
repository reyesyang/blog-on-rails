# -*- encoding : utf-8 -*-
class ArticlesController < ApplicationController
  before_filter :load_article_with_tags, only: [:show, :edit]
  load_and_authorize_resource

  def index
    @articles = current_user && current_user.admin? ?
      @articles.includes(:tags).paginate(:page => params[:page]) :
      @articles.includes(:tags).where("tags.name != 'draft'").paginate(:page => params[:page])

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
    @article = Article.new(params[:article])
    
    respond_to do |format|
      if @article.save
        format.html { redirect_to(@article, :notice => 'Article was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to(@article, :notice => 'Article was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

  private
  def load_article_with_tags
    @article = Article.includes(:tags).find(params[:id])
  end
end
