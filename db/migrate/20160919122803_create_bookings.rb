class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.index      :id
      t.date       :date
      t.integer    :user_id, index: true
      t.integer    :hotel_id, index: true
      t.timestamps null: false
    end
    add_foreign_key :bookings, :users
    add_foreign_key :bookings, :hotels
  end
end
