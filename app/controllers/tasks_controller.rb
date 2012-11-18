class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  load_and_authorize_resource
  before_filter :find_topic
  after_filter :sumtime, :only => [:update, :create, :destroy]
  after_filter :timeconvert, :only => [:update]
  before_filter :appname
  def index
    @tasks = @topic.tasks.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = @topic.tasks.find(params[:id])
    @timeeng = @task.time.split(".",2)
    @minssalt = '.' + @timeeng.last
    @minsraw = (@minssalt.to_d * 0.6) * 100
    @minseng = @minsraw.to_s.split(".",2)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = @topic.tasks.new(:topic_id => params[:topic_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = @topic.tasks.find(params[:id])
    @dipswitch = true
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @topic.tasks.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to topic_task_path(@topic, @task) }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = @topic.tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to topic_task_path(@topic), notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = @topic.tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to topic_tasks_url(@topic) }
      format.json { head :no_content }
    end
  end

  private
    def find_topic
      @topic = Topic.find(params[:topic_id])
      @project = @topic.project_id
    end

    def sumtime
      @topictasktime = @topic.tasks.sum(:time) 
      @topic.hoursused = @topictasktime
      @topic.save
    end

    def timeconvert
       if @task.time.include? ':'
        @timesplitters = @task.time.split(":",2)
        @mins_raw = (@timesplitters.last.to_d / 100) / 0.6
        @minseng = @mins_raw.to_s.split(".",2)
        @hours = @timesplitters.first
        @formattedtime = @hours.to_s + '.' + (@minseng.last).to_s
        @task.time = @formattedtime
        @task.save
      end
    end

    def appname
      @appname = 'TASKER'
    end
end










