class AddColumnToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :purchase_location, :string
  end
end
