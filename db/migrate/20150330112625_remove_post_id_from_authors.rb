class RemovePostIdFromAuthors < ActiveRecord::Migration
  def change
    remove_column :authors, :post_id
  end
end
