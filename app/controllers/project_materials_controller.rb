class ProjectMaterialsController < ApplicationController

  def index
    @project_material = ProjectMaterial.all

  end

  def create
    @project = Project.find(params[:project_id])
    @project_material = ProjectMaterial.new(project_material_params)
    @project_material.project = @project
    if @project_material.save
      redirect_to project_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @project_material = ProjectMaterial.new
    @materials = Material.all
    @project = Project.find(params[:project_id])
  end

  private

  def project_material_params
    params.require(:project_material).permit(:material_id)
  end

end
