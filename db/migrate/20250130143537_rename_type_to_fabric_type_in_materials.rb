class RenameTypeToFabricTypeInMaterials < ActiveRecord::Migration[7.1]
  def change
    rename_column :materials, :type, :fabric_type
  end
end
