class CreateUserComments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_comments do |t|
      t.integer :user_id
      t.integer :wine_id
      t.text :comment

      t.timestamps
    end
  end
end
