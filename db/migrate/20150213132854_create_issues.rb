class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.date :year
      t.string :title
      t.string :featured
      t.string :editorial_team
      t.string :credits
      t.string :cover_image

      t.timestamps
    end
  end
end
