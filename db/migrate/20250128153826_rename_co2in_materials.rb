class RenameCo2inMaterials < ActiveRecord::Migration[7.1]
  def change
    rename_column :materials, :CO2, :co2
  end
end
