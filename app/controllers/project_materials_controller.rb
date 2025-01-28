class ProjectMaterialsController < ApplicationController

  def index
    @project_material = ProjectMaterial.all

  end

  def create
    @project_material = ProjectMaterial.new(project_material_params)
    if @project_material.save
      redirect_to project_material_path
    else render :new, status: :unprocessable_entity
    end
  end

  def new
    @project_material = ProjectMaterial.new
  end

  private

  def project_materials_params
    params.require(:project_material).permit(:material_id, :project_id)
  end

end
