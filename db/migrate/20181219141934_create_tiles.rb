class CreateTiles < ActiveRecord::Migration[5.2]
  def change
    create_table :tiles do |t|
      t.references :map, index: true, foreign_key: true
      t.references :island, index: true
      t.integer :x, null: false
      t.integer :y, null: false
      t.integer :kind, null: false
      t.timestamps
    end
  end
end
