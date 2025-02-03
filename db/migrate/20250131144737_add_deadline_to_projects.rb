class AddDeadlineToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :deadline, :datetime
  end
end
