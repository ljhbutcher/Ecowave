class AddFiberCompositionToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :fiber_composition, :string
  end
end
