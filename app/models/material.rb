class Material < ApplicationRecord
  has_many :projects, through: :project_materials
  has_many :project_materials, dependent: :destroy
  has_one_attached :photo

  validates :length, numericality: { greater_than: 0 }, allow_nil: true
  validates :width, numericality: { greater_than: 0 }, allow_nil: true
  validates :grams_per_square_meter, numericality: { greater_than: 0 }, allow_nil: true

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
