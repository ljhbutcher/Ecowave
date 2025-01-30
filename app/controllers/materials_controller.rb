class MaterialsController < ApplicationController
  def index
    @materials = Material.all
  end

  def show
    @material = Material.find(params[:id])
    @project = Project.find(params[:project_id]) if params[:project_id].present?
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(materials_params)
    if @material.save
      redirect_to materials_path, notice: "Material was successfully added."
    else
      Rails.logger.debug @material.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])
    if @material.update (materials_params)
      redirect_to material_path
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
  end

  private
  def materials_params
    params.require(:material).permit(:name, :weight, :supplier, :amount, :fiber, :colour, :origin, :purchase_location, :certifications, :length, :width, :weight)
  end
end
