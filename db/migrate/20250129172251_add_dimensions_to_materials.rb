class AddDimensionsToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :length, :float
    add_column :materials, :width, :float
    add_column :materials, :grams_per_square_meter, :float
  end
end
