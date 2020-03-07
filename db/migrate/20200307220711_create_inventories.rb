class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.integer :wine_id
      t.integer :owner_id
      t.string :location
      t.integer :price
      t.date :end_date

      t.timestamps
    end
  end
end
