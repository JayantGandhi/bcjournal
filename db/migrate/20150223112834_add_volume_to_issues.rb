class AddVolumeToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :volume, :integer
  end
end
