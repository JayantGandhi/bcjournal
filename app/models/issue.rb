class Issue < ActiveRecord::Base

  before_create :update_slug
  before_save :update_slug

  mount_uploader :cover_image, CoverImageUploader
  mount_uploader :pdf, AttachmentUploader

  has_many :posts
  accepts_nested_attributes_for :posts, allow_destroy: false

  def to_param
    slug
  end

  def self.search(search)
    if search
      where('lower(title) LIKE ?', "%#{search.downcase}%")
    else
      all
    end
  end

  def update_slug
    self.slug = "vol-#{self.volume}-iss-#{self.issue_no}"
  end

end
