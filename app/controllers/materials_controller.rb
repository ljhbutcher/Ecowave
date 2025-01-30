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
    @material = Material.new(material_params)
    if @material.save
      redirect_to material_path(@material)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])
    if @material.update(material_params)
      redirect_to material_path(@material)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    redirect_to materials_path
  end

  private

  def material_params
    params.require(:material).permit(:name, :weight, :amount, :supplier, :origin_production, :purchase_location, :photo)
  end
end
