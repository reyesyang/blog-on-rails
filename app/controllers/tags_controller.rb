class TagsController < ApplicationController
  before_filter :load_tag_by_name, only: [:show]

  def show
    @articles = @tag.articles.includes(:tags).paginate(page: params[:page])
    render 'articles/index'
  end

  def to_param
    name
  end

  def self.list(user)
    if user && user.admin?
      Tag.all
    else
      Tag.where("name != 'draft'").all
    end
  end

  private
  def load_tag_by_name
    @tag = Tag.find_by_name params[:id]
  end
end
