class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    if params[:query].present?
      @projects = Project.where("name ILIKE ? OR description ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @projects = Project.all
    end
    params[:query] = ""
  end

  def show
    @project = Project.find(params[:id])
    @project_materials = @project.project_materials.includes(:material)
    @project_material = ProjectMaterial.new
    @summary = @project.build_summary if @project.summary.nil?

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
     @project.update(project_params)
      redirect_to project_path(@project), notice: 'Project was successfully updated.'

      @summary = @project.summary
      if @summary.update(summary_params)
        redirect_to @project, notice: 'Summary was successfully updated.'
      else
        render :show
      end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully destroyed.'
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def summary_params
    params.require(:summary).permit(:content)
  end
end
