class Project < ApplicationRecord
  has_many :materials, through: :project_materials
  has_many :project_materials, dependent: :destroy
end
