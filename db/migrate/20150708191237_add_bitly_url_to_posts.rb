class AddBitlyUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :bitly_url, :string
  end
end
