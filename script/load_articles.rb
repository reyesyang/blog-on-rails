Article.transaction do
	(1..20).each do |i|
		Article.create(:title => "Article #{i}",
			:summary => "Summary #{i}",
			:content => "Content #{i}")
	end
end
	
