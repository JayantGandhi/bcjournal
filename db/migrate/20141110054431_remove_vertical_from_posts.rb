class RemoveVerticalFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :vertical
    add_column :posts, :vertical_id, :integer
  end
end
