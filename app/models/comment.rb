class Comment < ActiveRecord::Base
  include Gravtastic
  gravtastic :visitor_email,
             :secure => false,
             :filetype => :gif,
             :size => 40,
             :rating => :G

  validates :content, :presence => true
  belongs_to :article
end
