class Slideshow < ActiveRecord::Base

  has_and_belongs_to_many :posts

  accepts_nested_attributes_for :posts, allow_destroy: true

end
