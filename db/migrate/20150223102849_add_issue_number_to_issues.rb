class AddIssueNumberToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :issue_no, :integer
  end
end
