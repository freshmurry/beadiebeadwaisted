class CreateBeads < ActiveRecord::Migration
  def change
      create_table :beads do |t|
      t.integer :waist_size
      t.string :listing_name
      t.text :summary
      t.integer :price
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
