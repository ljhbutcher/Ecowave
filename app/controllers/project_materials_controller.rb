class ProjectMaterialsController < ApplicationController
  before_action :set_project


  def index
    @project_material = ProjectMaterial.all
    if params[:query].present?
      @materials = current_user.materials.where("fabric_type ILIKE ? OR fiber ILIKE ? OR colour ILIKE ?",
                                  "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @materials = current_user.materials
    end
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

  def destroy
    @material = Material.find(params[:id])
    @project_material = ProjectMaterial.find_by(project: @project, material: @material)
    @project_material.destroy

    redirect_to project_path(@project)
  end

  private

  def project_material_params
    params.require(:project_material).permit(:material_id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_material
    @material = Material.find(params[:material_id])
  end


end
