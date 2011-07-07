module ArticlesHelper
	def join_tags(article)
		article.tags.map { |t| t.name }.join(", ")
	end
end
