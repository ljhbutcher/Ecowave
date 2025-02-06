class ChangeDeadlineTypeInProjects < ActiveRecord::Migration[7.1]
  def change
    change_column :projects, :deadline, :date
  end
end
