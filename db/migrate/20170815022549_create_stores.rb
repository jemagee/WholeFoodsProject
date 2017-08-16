class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.text :name
      t.integer :number
      t.references :region, foreign_key: true
      t.boolean :open, default: true

      t.timestamps
    end
  end
end
