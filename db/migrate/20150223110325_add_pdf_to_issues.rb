class AddPdfToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :pdf, :string
  end
end
