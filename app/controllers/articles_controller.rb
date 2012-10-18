# -*- encoding : utf-8 -*-
class ArticlesController < ApplicationController
  skip_before_filter :authorize, :only => [:index, :show, :tagged]
  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.includes(:tags).paginate(:page => params[:page],
                                                 :order => 'created_at desc')
    @page_title = '首页'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.includes(:tags).find(params[:id])
    @page_title = '文章 - ' + @article.title
    @page_description = @article.title

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
    @page_title = '发布文章'

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.includes(:tags).find(params[:id])
    @page_title = '编辑文章 - ' + @article.title
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article])
    
    respond_to do |format|
      if @article.save
        format.html { redirect_to(@article, :notice => 'Article was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])
    
    respond_to do |format|
      if @article.update_attributes(params[:article])
			#if @article.save
        format.html { redirect_to(@article, :notice => 'Article was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

	# GET /articles/tag/1
	def tagged
    #tag = Tag.find params[:tag_id]
    tag = Tag.find_by_name params[:tag]
    @articles = tag.articles.includes(:tags).paginate(:page => params[:page],
                                                      :order => 'created_at DESC')
    @page_title = @page_description = '标签为' + tag.name + '的文章'

		respond_to do |format|
			format.html { render 'index' }
			format.xml  { render :xml => @articles }
		end
	end
end
