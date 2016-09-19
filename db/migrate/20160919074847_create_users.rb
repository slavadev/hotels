class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.index    :id
      t.string   :email, default: '', index: true
      t.string   :encrypted_password, default: ''
      t.string   :salt, default: ''
      t.datetime :confirmed_at
      t.timestamps null: false
    end
  end
end
