class RemoveAuthorsFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :author
  end
end
