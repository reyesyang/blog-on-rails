module ArticlesHelper
  def join_tags(article)
    article.tags.map { |tag| "<a href='/articles/tag/#{tag.id}'>#{tag.name}</a>" }.join("; ")
  end
end
