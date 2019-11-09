class TasksController < ApplicationController
  before_action :fetch_current_task, only: [:show, :edit, :confirm_edit]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new 
  end

  def confirm_new
    @task = Task.new(task_params)
    
    if @task.valid?
    else
      render 'new'
    end
  end

  def create
    @task = Task.new(task_params)

    if params[:back].present?
      render 'new'
      return      
    end
    
    if @task.save
      flash[:success] = 'Success in creating task'
      redirect_to task_path @task.id
    else
      render 'confirm_new'
    end
  end

  def show
  end

  def edit
  end

  def confirm_edit
    @task.attributes = task_params

    if @task.valid?
    else
      render 'edit'
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :detail, :deadline, :label)
  end

  def fetch_current_task
    @task = Task.find(params[:id])
  end
end
