class Author < ActiveRecord::Base
  has_many :authorships, :dependent => :destroy
  has_many :posts, :through => :authorships
end
