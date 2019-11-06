class TasksController < ApplicationController
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
    byebug
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
    @task = Task.find(params[:id])
  end

  private

  def task_params
    params.require(:task).permit(:title, :detail, :deadline, :label)
  end
end
