class CreatePostsSlideshowsJoinTable < ActiveRecord::Migration
  def change
    create_table :posts_slideshows, id: false do |t|
      t.integer :post_id
      t.integer :slideshow_id
    end
  end
end
