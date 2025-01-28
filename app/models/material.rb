class Material < ApplicationRecord
  has_many :projects, through: :project_material
  has_many :project_materials, dependent: :destroy
  has_one_attached :photo
end
