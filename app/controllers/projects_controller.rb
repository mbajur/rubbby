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
  end

  # GET  /projects/new
  # POST /projects/new
  def new
    @project = Project.new

    case request.method
    when 'GET'
      render 'new_github'

    when 'POST'
      project = Project.find_by(full_name: params[:full_name])

      if project
        redirect_to project, notice: "#{project.name} is already here, have a look"
        return
      end

      gh_client = Octokit::Client.new(current_user.services.last.token)
      @gh_repo  = gh_client.repository params[:full_name]

      @project.full_name = @gh_repo.full_name

      render 'new'
    end
  end

  # GET /projects/1/edit
  # def edit
  # end

  # POST /projects
  def create
    @project = Project.new(project_params).decorate

    respond_to do |format|
      if @project.save
        @project.fetch_github_data
        @project.touch_points

        format.html { redirect_to @project.path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
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
      params.require(:project).permit(:full_name)
    end

    def apply_scope_filters
      @projects = case params[:scope]
        when 'top'    then @projects.top
        when 'recent' then @projects.recent
        else @projects.hot
      end
    end
end
