class Project < ApplicationRecord
  has_many :project_materials, dependent: :destroy
  has_many :materials, through: :project_materials
  has_one_attached :photo
end
