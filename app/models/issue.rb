class Issue < ActiveRecord::Base

  mount_uploader :cover_image, CoverImageUploader

  has_many :posts
  accepts_nested_attributes_for :posts, allow_destroy: false

  def to_param
    slug
  end

end
