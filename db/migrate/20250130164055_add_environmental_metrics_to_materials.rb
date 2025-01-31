class AddEnvironmentalMetricsToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :summary, :text
  end
end
