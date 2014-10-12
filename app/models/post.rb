class Post < ActiveRecord::Base

  mount_uploader :cover_image, CoverImageUploader


  validates :title, presence: true
  validates :by_line, presence: true
end
