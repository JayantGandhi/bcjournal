class AddWeightToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :weight, :integer
  end
end
