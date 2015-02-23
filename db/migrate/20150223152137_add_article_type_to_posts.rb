class AddArticleTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :article_type, :string
  end
end
