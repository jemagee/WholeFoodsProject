class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.text :name
      t.integer :prefix
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
