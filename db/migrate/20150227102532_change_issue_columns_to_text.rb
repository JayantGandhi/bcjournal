class ChangeIssueColumnsToText < ActiveRecord::Migration
  def change
    change_column :issues, :featured, :text
    change_column :issues, :editorial_team, :text
    change_column :issues, :credits, :text
  end
end
