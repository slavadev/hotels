class CreateHotels < ActiveRecord::Migration[5.0]
  def change
    create_table :hotels do |t|
      t.index    :id
      t.string   :name, default: '', index: true
      t.timestamps null: false
    end
  end
end
