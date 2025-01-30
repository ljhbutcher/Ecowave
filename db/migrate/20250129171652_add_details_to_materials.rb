class AddDetailsToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :type, :string
    add_column :materials, :fiber, :string
    add_column :materials, :colour, :string
    add_column :materials, :origin, :string
    add_column :materials, :certifications, :string
  end
end
