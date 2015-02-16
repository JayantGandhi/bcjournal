class CreateRelatedArticles < ActiveRecord::Migration
  def change
    create_table :related_articles, :force => true, :id => false do |t|
      t.integer "post_a_id", :null => false
      t.integer "post_b_id", :null => false
    end
  end
end
