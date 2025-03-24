class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
    if params[:query].present?
      @projects = Project.where("name ILIKE ? OR description ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end
    params[:query] = ""
  end

  def show
    @project.reload
    @materials = Material.where(id: @project.material_ids)
    @material = @materials.first
    @project_materials = @project.project_materials.includes(:material)
    @project_material = ProjectMaterial.new
  end


  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    # Ensure summary gets updated if not manually provided
    @project.summary = @project.description if @project.summary.blank?

    if @project.save
      redirect_to project_path(@project), notice: "Project successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      respond_to do |format|
        format.html { redirect_to @project, notice: "Project updated successfully." }
        format.json { render json: { summary: @project.summary, notes: @project.notes } }
      end
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :summary, :notes, :deadline, :photo)
  end
end
