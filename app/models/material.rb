class Material < ApplicationRecord
  has_many :projects, through: :project_material
  has_one_attached :photo

  def self.avg_electricity
    average(:electricity_used)
  end

  def self.avg_water
    average(:water_usage)
  end

  def self.avg_co2
    average(:CO2)
  end

end
