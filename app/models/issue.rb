class Issue < ActiveRecord::Base

  before_save :build_slug

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

  def build_slug
    self.slug = "vol-#{self.volume}-iss-#{self.issue_no}"

    # make sure it's unique, if not add the year
    if !Issue.find_by_slug(self.slug).nil?
      self.issue_no += 1
      self.build_slug
    end
  end

end
