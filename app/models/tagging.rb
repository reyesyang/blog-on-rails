# encoding: UTF-8
class Tagging < ActiveRecord::Base
  belongs_to :article

  # :touch used to update tag when tagging was destroyed
  belongs_to :tag, counter_cache: :articles_count, touch: true
end
