class AddPhotoCreditToPost < ActiveRecord::Migration
  def change
    add_column :posts, :photo_credit, :string
    add_column :posts, :photo_url, :string
    add_column :posts, :photo_title, :string
  end
end
