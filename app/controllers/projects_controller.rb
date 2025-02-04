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
    @materials = @project.materials
    @material = @materials.first
    @project_materials = @project.project_materials.includes(:material)
    @project_material = ProjectMaterial.new
  end


  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    raise
    if @project.update(photo: project_params[:photo])
      respond_to do |format|
        format.html { redirect_to @project, notice: "Summary updated successfully." }
        format.json { render json: { summary: @project.summary, notes: @project.notes} }
      end
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully destroyed.'
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :summary, :notes, :photo)
  end

end
