class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name, null: false, unique: true
      t.integer :year, null: false, index: true
      t.string :manufacturer
      t.string :notes
      t.boolean :is_active, null: false, index: true
      t.references :photo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
