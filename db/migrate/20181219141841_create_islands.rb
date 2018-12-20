class CreateIslands < ActiveRecord::Migration[5.2]
  def change
    create_table :islands do |t|
      t.references :map, index: true, foreign_key: true
      t.timestamps
    end
  end
end
