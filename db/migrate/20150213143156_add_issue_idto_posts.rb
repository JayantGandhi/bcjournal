class AddIssueIdtoPosts < ActiveRecord::Migration
  def change
    add_column :posts, :issue_id, :integer
  end
end
