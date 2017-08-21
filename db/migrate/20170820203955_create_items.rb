class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.text :name
      t.integer :number
      t.references :brand, foreign_key: true

      t.timestamps
    end
  end
end
