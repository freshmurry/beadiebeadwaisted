class AddFieldsToBead < ActiveRecord::Migration
  def change
    add_column :beads, :latitude, :float
    add_column :beads, :longitude, :float
  end
end