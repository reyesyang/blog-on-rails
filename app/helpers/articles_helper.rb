module ArticlesHelper
  def join_tags(article)
    article.tags.map { |t| "test" + t.name }.join("; ")
  end
end
