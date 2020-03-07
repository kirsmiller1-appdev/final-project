class CreateWines < ActiveRecord::Migration[6.0]
  def change
    create_table :wines do |t|
      t.integer :vintage
      t.string :vineyard
      t.string :blend
      t.integer :expert_rating
      t.text :expert_notes
      t.string :photo_url
      t.string :external_url

      t.timestamps
    end
  end
end
