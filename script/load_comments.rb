Comment.transaction do
	(1..20).each do |i|
		Comment.create(:commenter => "Commenter #{i}",
			:content => 'Comment content<br/>Comment content',
			:article_id => '20')
	end
end
