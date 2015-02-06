class CreatePortals < ActiveRecord::Migration
  def change
    create_table :portals do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :lng

      t.timestamps null: false

      t.index [:lat, :lng], :unique => true
    end
  end
end
