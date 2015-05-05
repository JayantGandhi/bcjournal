class AddBookAuthorToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :book_author, :string
  end
end
