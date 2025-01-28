class MaterialsController < ApplicationController
  def index
    @materials = Material.all
  end

  def show
    @material = Material.find(params[:id])
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(materials_params)
    if @material.save
      redirect_to material_path
    else render :new, status: :unprocessable_entity
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
    params.require(:material).permit(:name, :weight, :supplier, :amount)
  end


end
