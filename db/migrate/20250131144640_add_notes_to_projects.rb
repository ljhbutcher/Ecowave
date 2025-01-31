class AddNotesToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :notes, :text
  end
end
