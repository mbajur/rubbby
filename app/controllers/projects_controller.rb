class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.all.page(params[:page])
    @projects_count = Project.count(:id)
    apply_scope_filters
  end

  # GET /gems
  def gems
    @projects = Project.gems.page(params[:page])
    @projects_count = Project.gems.count(:id)
    apply_scope_filters
  end

  # GET /projects
  def apps
    @projects = Project.apps.page(params[:page])
    @projects_count = Project.apps.count(:id)
    apply_scope_filters
  end

  # GET /projects/1
  def show
    @project = @project.decorate
  end

  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = Project.new(project_params).decorate
    @project.user = current_user

    if @project.save
      @project.fetch_data
      redirect_to @project.path, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  # def update
  #   respond_to do |format|
  #     if @project.update(project_params)
  #       format.html { redirect_to @project, notice: 'Project was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @project }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @project.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find_by(full_name: params[:full_name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:full_name, :is_gem, :is_app, :rubygem_name, :tag_ids => [])
    end

    def apply_scope_filters
      @projects = case params[:scope]
        when 'top'    then @projects.top
        when 'recent' then @projects.recent
        else @projects.hot
      end
    end
end
