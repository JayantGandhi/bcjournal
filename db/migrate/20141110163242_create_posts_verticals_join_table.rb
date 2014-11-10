class CreatePostsVerticalsJoinTable < ActiveRecord::Migration
  def change
    create_table :posts_verticals, id: false do |t|
      t.integer :post_id
      t.integer :vertical_id
    end
  end
end
