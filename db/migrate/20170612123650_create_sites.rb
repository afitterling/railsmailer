class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :uid
      t.string :recipient

      t.timestamps null: false
    end
    add_index :sites, :uid, unique: true
  end
end
