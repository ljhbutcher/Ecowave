class MaterialsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:query].present?
      @materials = current_user.materials.where("fabric_type ILIKE ? OR fiber ILIKE ? OR colour ILIKE ?",
                                  "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @materials = current_user.materials
    end
  end

  def show
    @material = Material.find(params[:id])
    @project = Project.find(params[:project_id]) if params[:project_id].present?
  end

  def new
    @material = Material.new
  end

  def create
    @material = current_user.materials.build(material_params)
    if @material.save
      redirect_to @material, notice: 'Material was successfully created.'
    else
      render :new
    end
  end

  # Optionally, if you want a manual trigger for AI metrics:
  def process_ai
    @material = Material.find(params[:id])
    metrics = @material.calculate_environmental_metrics

    if @material.update(metrics)
      redirect_to @material, notice: 'Material updated with AI analysis'
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
      redirect_to @material, notice: 'Material updated successfully.'
    else
      render :edit
    end
  end

  def edit_quantity
    @material = Material.find(params[:id])
  end

  def update_quantity
    @material = Material.find(params[:id])
    if @material.update(quantity_params)
      redirect_to @material, notice: 'Quantity updated successfully.'
    else
      render :edit_quantity
    end
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    redirect_to materials_path
  end

  private

  def material_params
    params.require(:material).permit(
      :fabric_type, :fiber, :length, :width, :grams_per_square_meter,
      :colour, :texture, :origin, :supplier, :product_code, :purchase_location,
      :purchase_date, :price_per_meter, :certifications, :notes, :photo
    )
  end

  def quantity_params
    params.require(:material).permit(:length)
  end
end
