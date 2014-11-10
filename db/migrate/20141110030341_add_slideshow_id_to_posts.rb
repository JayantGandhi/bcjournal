class AddSlideshowIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slideshow_id, :integer
  end
end
