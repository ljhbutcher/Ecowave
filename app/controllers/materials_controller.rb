class MaterialsController < ApplicationController
  def index
    if params[:query].present?
      # Search for materials where the fabric type, fiber, or color matches the query
      @materials = Material.where("fabric_type ILIKE ? OR fiber ILIKE ? OR colour ILIKE ?",
                                  "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @materials = Material.all
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
    @material = Material.new(material_params)

    if @material.save
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
      redirect_to @material, notice: 'Material updated successfully.'
    else
      render :edit
    end
  end

  def edit_quantity
    @material = Material.find(params[:id])
    # Render edit_quantity.html.erb (you can include a form for adjusting quantity)
  end

  def edit_history
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

  def update_quantity
    @material = Material.find(params[:id])
    previous_length = @material.length

    if @material.update(material_params_2)
      MaterialHistory.create!(
        material: @material,
        previous_length: previous_length,
        new_length: @material.length,
        changed_at: Time.current
      )
      redirect_to @material, notice: "Quantity updated successfully."
    else
      render :edit_quantity, alert: "Failed to update quantity."
    end
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    redirect_to materials_path
  end

  private

  def materials_params
    params.require(:material).permit(:name, :weight, :supplier, :amount, :fiber, :colour, :origin, :purchase_location, :certifications, :length, :width, :weight)
  end

  def material_params
    params.require(:material).permit(
      :fabric_type, :fiber, :length, :width, :grams_per_square_meter,
      :colour, :texture, :origin, :supplier, :product_code, :purchase_location,
      :purchase_date, :price_per_meter, :certifications, :notes, :photo
    )
  end

  def quantity_params
    params.require(:material).permit(:length)  # or whatever attribute represents quantity
  end

  def material_params_2
    params.require(:material).permit(:length)
  end
end
