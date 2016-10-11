class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :url, null: false, unique: true
      t.string :thumb, unique: true
      t.timestamps null: false
    end
  end
end
