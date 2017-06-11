class AddUidToMailers < ActiveRecord::Migration
  def change
    add_column :mailers, :uid, :string
    add_index :mailers, :uid, unique: true
  end
end
