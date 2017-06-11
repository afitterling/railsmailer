class CreateMailers < ActiveRecord::Migration
  def change
    create_table :mailers do |t|
      t.string :address, default: "localhost", null: false
      t.integer :port, default: 25, null: false
      t.string :domain
      t.string :user_name
      t.string :encrypted_password
      t.string :encrypted_password_iv
      t.integer :authentication
      t.boolean :enable_starttls_auto, default: true, null: false
      t.string :openssl_verify_mode

      t.timestamps null: false
    end
  end
end
