class AddBookReviewInfoToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :author, :string
    add_column :posts, :publisher, :string
    add_column :posts, :book_publish_date, :date
    add_column :posts, :price, :float
    add_column :posts, :link_to_book, :string
  end
end
