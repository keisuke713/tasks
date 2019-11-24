class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :confirm_new, :create, :show]
  before_action :fetch_current_task, only: [:show, :edit, :confirm_edit, :update]
  before_action :confirm_user_created_task, only: :show
  before_action :set_attributes_to_task, only: [:confirm_edit, :update]

  def index
    @tasks = Task.where(user: current_user) 
  end

  def new
    @task = current_user.tasks.build 
  end

  def confirm_new
    @task = current_user.tasks.build(task_params)
    if @task.valid?

    else
      render 'new'
    end
  end

  def create
    @task = current_user.tasks.build(task_params)

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
    if @task.valid?
    else
      render 'edit'
    end
  end

  def update
    if params[:back].present?
      render 'edit'
      return
    end

    if @task.save
      flash[:success] = 'success in editing task'
      redirect_to task_path @task.id
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :detail, :deadline, :status, :label)
  end

  def fetch_current_task
    @task = Task.find(params[:id])
  end

  def set_attributes_to_task
    @task.attributes = task_params
  end

  def confirm_user_created_task 
    unless @task.created_by_current_user?(current_user)     
      flash[:danger] = '自分の作成したタスク以外は閲覧できません' 
      redirect_to '/' 
    end
  end
end
