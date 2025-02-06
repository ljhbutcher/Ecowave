class Project < ApplicationRecord
  has_many :project_materials, dependent: :destroy
  has_many :materials, through: :project_materials
  has_one_attached :photo


  def average_water_usage
    return 0 if materials.empty?
    materials.average(:water_usage).to_f
  end

  def average_co2_emissions
    return 0 if materials.empty?
    materials.average(:co2).to_f
  end

  def average_electricity_usage
    return 0 if materials.empty?
    materials.average(:electricity_used).to_f
  end


  def sustainability_score
    return 100 if materials.empty? # Default score if no materials

    scores = materials.map(&:sustainability_score) # Get scores of all materials
    (scores.sum / scores.size.to_f).round # Average score
  end

end
