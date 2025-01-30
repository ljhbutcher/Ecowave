class RemoveMultipleColumnsFromMaterials < ActiveRecord::Migration[7.1]
  def change
    remove_column :materials, :purchase_location, :string
    remove_column :materials, :amount, :float

  end
end
