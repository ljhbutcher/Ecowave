class Material < ApplicationRecord
  has_many :projects, through: :project_material
  has_one_attached :photo
end
