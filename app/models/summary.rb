class Summary < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true
  belongs_to :material, optional: true
end
