class Post < ActiveRecord::Base

  mount_uploader :cover_image, CoverImageUploader

  has_many :sections, -> { order 'position ASC' }

  has_and_belongs_to_many :verticals
  has_and_belongs_to_many :slideshows

  acts_as_taggable

  accepts_nested_attributes_for :sections, allow_destroy: true
  accepts_nested_attributes_for :verticals, allow_destroy: true

  validates :title, presence: true
  validates :by_line, presence: true
  validates :blurb, presence: true, length: {maximum: 400}
  validates :slug,
    uniqueness: {
      case_sensitive: false
    },
    presence: true

  # scopes
  scope :published, -> { where(published: true) }

  # methods
  def to_param
    slug
  end

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
