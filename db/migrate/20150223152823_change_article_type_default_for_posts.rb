class ChangeArticleTypeDefaultForPosts < ActiveRecord::Migration
  def change
    change_column :posts, :article_type, :string, default: 'scholarly research'
  end
end
