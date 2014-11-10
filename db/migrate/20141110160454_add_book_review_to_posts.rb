class AddBookReviewToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :book_review, :boolean, default: false
  end
end
