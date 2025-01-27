class Project < ApplicationRecord
  has_many :materials, through: :project
end
