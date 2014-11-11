class AddAuthorBioToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :author_bio, :text
  end
end
