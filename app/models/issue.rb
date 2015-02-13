class Issue < ActiveRecord::Base

  mount_uploader :cover_image, CoverImageUploader

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

end
