class ArticlesController < ApplicationController
  skip_before_filter :authorize, :only => [:index, :show, :get_articles_by_tag_id]
  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.paginate(:page => params[:page],
			:order => 'created_at desc',
			:per_page => 7)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])
		@comments = Comment.paginate_by_sql(['select * from comments where article_id=? order by created_at desc', params[:id]],
			:page => params[:page],
			:per_page => 7)
		@comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
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
		params[:article][:tags_attributes].each do |tag_array|
			tag_hash = tag_array[1]
			tag = Tag.find_by_name(tag_hash[:name])
			if tag
				#debugger
				if tag_hash[:_destroy] == "1"
					@article.tags.delete tag
				else
					exist = @article.tags.exists?(tag)
					@article.tags << tag unless exist
				end
			else
				if tag_hash[:name] != ""
					tag = Tag.create(:name => tag_hash[:name])
					@article.tags << tag
				end
			end
		end

    respond_to do |format|
      #if @article.update_attributes(params[:article])
			if @article.save
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
	def get_articles_by_tag_id
		@articles = Article.paginate_by_sql(['select * from articles inner join articles_tags on articles.id=articles_tags.article_id where articles_tags.tag_id=?', params[:tag_id]],
		:page => params[:page],
		:per_page => 7)

		respond_to do |format|
			format.html { render 'index' }
			format.xml  { render :xml => @articles }
		end
	end
end
