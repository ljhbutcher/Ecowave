class AddSummaryToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :summary, :text
  end
end
