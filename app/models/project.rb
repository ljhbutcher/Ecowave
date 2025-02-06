class Project < ApplicationRecord
  has_many :project_materials, dependent: :destroy
  has_many :materials, through: :project_materials
  has_one_attached :photo

  before_save :sync_summary_with_description

  # Sync summary with description if summary is blank
  def sync_summary_with_description
    self.summary = description if summary.blank?
  end

  # Calculate average water usage of materials
  def average_water_usage
    return 0 if materials.empty?
    materials.average(:water_usage).to_f
  end

  # Calculate average CO2 emissions of materials
  def average_co2_emissions
    return 0 if materials.empty?
    materials.average(:co2).to_f
  end

  # Calculate average electricity usage of materials
  def average_electricity_usage
    return 0 if materials.empty?
    materials.average(:electricity_used).to_f
  end

  # Calculate overall sustainability score
  def sustainability_score
    return 100 if materials.empty? # Default score if no materials

    scores = materials.map(&:sustainability_score) # Get scores of all materials
    (scores.sum / scores.size.to_f).round # Average score
  end
end
