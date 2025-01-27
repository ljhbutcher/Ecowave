class CreateMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :materials do |t|
      t.string :name
      t.float :weight
      t.string :supplier
      t.float :amount
      t.string :origin_production
      t.string :purchase_location
      t.float :CO2
      t.float :water_usage
      t.float :electricity_used

      t.timestamps
    end
  end
end
