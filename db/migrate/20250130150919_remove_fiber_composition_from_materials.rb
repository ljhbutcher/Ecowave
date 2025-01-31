class RemoveFiberCompositionFromMaterials < ActiveRecord::Migration[7.1]
  def change
    remove_column :materials, :fiber_composition, :string
  end
end
