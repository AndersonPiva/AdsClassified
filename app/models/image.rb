class Image < ActiveRecord::Base
  belongs_to :advertisement

  has_attached_file :cover, styles: { :medium => "50x50>", :tiny => "30x30" }, default_url: ("/img/missing.png")
  validates_attachment_content_type :cover, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
