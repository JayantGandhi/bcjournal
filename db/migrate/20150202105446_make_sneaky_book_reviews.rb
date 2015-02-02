class MakeSneakyBookReviews < ActiveRecord::Migration
  def change
    change_column_default :posts, :book_review, false
  end
end
