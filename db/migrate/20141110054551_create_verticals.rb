class CreateVerticals < ActiveRecord::Migration
  def change
    create_table :verticals do |t|
      t.string :name

      t.timestamps
    end
  end
end
