# encoding: UTF-8
class Tagging < ActiveRecord::Base
  belongs_to :article
  belongs_to :tag, counter_cache: :articles_count, touch: true
end
