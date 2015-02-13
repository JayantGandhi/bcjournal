class AddSlugToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :slug, :string
  end
end
