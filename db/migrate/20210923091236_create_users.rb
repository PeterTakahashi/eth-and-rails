class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :eth_address
      t.string :eth_nonce
      t.timestamps

      t.index [:username], unique: true
      t.index [:eth_address], unique: true
      t.index [:eth_nonce], unique: true
    end
  end
end
