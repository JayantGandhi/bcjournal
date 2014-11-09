class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :header
      t.text :body
      t.references :post

      t.timestamps
    end
  end
end
