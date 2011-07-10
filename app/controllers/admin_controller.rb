class AdminController < ApplicationController
  def index
    @total_articles = Article.count
  end

end
