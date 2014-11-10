class AddVerticalToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :vertical, :string
  end
end
