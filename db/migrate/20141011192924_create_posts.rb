class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :by_line
      t.text :content
      t.string :cover_image

      t.timestamps
    end
  end
end
