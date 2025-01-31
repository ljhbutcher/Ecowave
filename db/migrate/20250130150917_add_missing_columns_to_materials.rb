class AddMissingColumnsToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :texture, :string
    add_column :materials, :product_code, :string
    add_column :materials, :purchase_date, :date
    add_column :materials, :price_per_meter, :float
    add_column :materials, :notes, :text
  end
end
