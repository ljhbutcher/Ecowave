class AddUserIdToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :user_id, :integer
  end
end
