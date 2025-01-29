class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @project_materials = @project.project_materials.includes(:material)
    @project_material = ProjectMaterial.new
  end


  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path
    else render:new, status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

  end

  def destroy
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

end
