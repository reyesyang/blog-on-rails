# -*- encoding : utf-8 -*-
module ApplicationHelper
  def format_text(text, options = {})
    sanitize markdown(text)
  end

  def markdown(text)
    markdown_render = Redcarpet::Render::HTML.new no_style: true, hard_wrap: true
    markdown = Redcarpet::Markdown.new(markdown_render,
                                       autolink: true,
                                       no_intra_emphasis: true,
                                       fenced_code_blocks: true,
                                       strikethrough: true,
                                       superscript: true)
    markdown.render(text.to_s)
  end
  
  def join_tags(article)
    article.tags.map { |tag| "<a href='/articles/tag/#{tag.id}'>#{tag.name}</a>" }.join("; ")
  end

  def cache_key_for_tags
    last_updated_at = Tag.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "tags-#{last_updated_at}"
  end
end
