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
      redirect_to materials_path, notice: "Material was successfully added."
    else
      Rails.logger.debug @material.errors.full_messages
      render :new, status: :unprocessable_entity
      redirect_to process_ai_material_path(@material)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def process_ai
    @material = Material.find(params[:id])
    metrics = @material.calculate_environmental_metrics

    if @material.update(metrics)
      redirect_to @material, notice: 'Material created with AI analysis'
    else
      redirect_to materials_path, alert: 'Error processing AI metrics'
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
<<<<<<< HEAD
  def materials_params
    params.require(:material).permit(:name, :weight, :supplier, :amount, :fiber, :colour, :origin, :purchase_location, :certifications, :length, :width, :weight)
=======

  def material_params
    params.require(:material).permit(
      :fabric_type, :fiber, :length, :width, :grams_per_square_meter,
      :colour, :texture, :origin, :supplier, :product_code, :purchase_location,
      :purchase_date, :price_per_meter, :certifications, :notes, :photo
    )
>>>>>>> 1be30888163f47a479db5ebe6d46d261ca8865f2
  end
end
