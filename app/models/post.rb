class Post < ActiveRecord::Base

  mount_uploader :cover_image, CoverImageUploader

  has_many :sections

  accepts_nested_attributes_for :sections, allow_destroy: true

  validates :title, presence: true
  validates :by_line, presence: true
end
