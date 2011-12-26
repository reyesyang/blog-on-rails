class CommentsController < ApplicationController
  skip_before_filter :authorize, :only => :create

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(params[:comment])

    if @comment.save
      redirect_to @article
    else
      render :new
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end
end
