class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.references :bead, index: true, foreign_key: true
      t.string :address
      t.integer :waist_size
      t.integer :price
      t.integer :total

      t.timestamps null: false
    end
  end
end