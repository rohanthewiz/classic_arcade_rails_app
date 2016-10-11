class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :fan_ip, index: true, null: false
      t.references :game, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
