class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home, :materials ]

  def home
  end

  def index
    @materials = Material.all
  end
end
