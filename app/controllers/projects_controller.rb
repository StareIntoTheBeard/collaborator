class ProjectsController < ApplicationController
  
  before_filter :find_project, except: [:index, :new, :create] 
  before_filter :refresh_labels, only: :edit

  load_and_authorize_resource :through => :current_user

  # GET /projects
  # GET /projects.json
  def index
    # @projects = Project.accessible_by(current_user)
    if can? :manage, Project
      @projects = Project.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end


  # GET /projects/1
  # GET /projects/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    respond_to do |format|
      # If all set to zero..
      params[:project][:user_ids] ||= []
      params[:enable_label] ||= []

      # no validation check needed. Boolean.
      @project.update_labels(params[:enable_label])

      if @project.update_attributes(params[:project]) 
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private

  def find_project
    id = params[:id] || params[:project_id]
    @project = Project.find(id)
    authorize! :read, @project
  end

  def refresh_labels
    external_labels = @octokit.labels(@project.repo)

    external_labels.each do |label|
      unless @project.labels.find_by_name(label.name) 
        @label = @project.labels.build ({name: label.name, color: label.color})
        @label.save
      end
    end

  end

end