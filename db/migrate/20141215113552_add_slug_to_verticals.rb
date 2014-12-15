class AddSlugToVerticals < ActiveRecord::Migration
  def change
    add_column :verticals, :slug, :string
  end
end
