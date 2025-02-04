class CreateMaterialHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :material_histories do |t|
      t.references :material, null: false, foreign_key: true
      t.integer :previous_length
      t.integer :new_length
      t.datetime :changed_at

      t.timestamps
    end
  end
end
