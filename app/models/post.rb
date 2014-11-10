class Post < ActiveRecord::Base

  mount_uploader :cover_image, CoverImageUploader

  has_many :sections

  belongs_to :vertical
  belongs_to :slideshow

  accepts_nested_attributes_for :sections, allow_destroy: true

  validates :title, presence: true
  validates :by_line, presence: true
  validates :blurb, presence: true, length: {maximum: 200}
  validates :slug,
    uniqueness: {
      case_sensitive: false
    },
    presence: true

  def to_param
    slug
  end
end
