# encoding: UTF-8
class Tagging < ActiveRecord::Base
  # :touch used to update article when new tag was added
  belongs_to :article, touch: true

  # :touch used to update tag when tagging was destroyed
  belongs_to :tag, counter_cache: :articles_count, touch: true
end
