class AddAbstractAndNotesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :abstract, :text
    add_column :posts, :notes, :text
  end
end
