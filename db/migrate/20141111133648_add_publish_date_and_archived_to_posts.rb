class AddPublishDateAndArchivedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :publish_date, :date
    add_column :posts, :archived, :boolean, default: false
  end
end
