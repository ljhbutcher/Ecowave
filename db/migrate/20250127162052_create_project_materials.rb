class CreateProjectMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :project_materials do |t|
      t.references :material, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
