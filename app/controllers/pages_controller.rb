class PagesController < ApplicationController
  # Skip authentication only for the landing page
  skip_before_action :authenticate_user!, only: [:landing_page]

  # This action renders app/views/pages/landing_page.html.erb
  def landing_page
    # No authentication needed here—this is your public landing page.
  end

  def home
    # This action requires the user to be authenticated.
    materials = current_user.materials
    Rails.logger.debug "Current user has #{materials.count} materials."

    if materials.any?
      scores = materials.map do |material|
        water = material.water_usage.to_f
        co2 = material.co2.to_f
        electricity = material.electricity_used.to_f

        water_threshold = 2000.0
        co2_threshold = 2.0
        electricity_threshold = 1.0

        water_score = water > 0 ? [100 - ((water / water_threshold) * 100), 0].max : 100
        co2_score = co2 > 0 ? [100 - ((co2 / co2_threshold) * 100), 0].max : 100
        electricity_score = electricity > 0 ? [100 - ((electricity / electricity_threshold) * 100), 0].max : 100

        ((water_score + co2_score + electricity_score) / 3.0).round
      end

      @average_score = (scores.sum.to_f / scores.size).round
    else
      @average_score = 0
    end
  end

  def index
    @materials = current_user.materials
  end
end
