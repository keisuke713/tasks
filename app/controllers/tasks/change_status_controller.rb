class Tasks::ChangeStatusController < ApplicationController
  def update
    @task = Task.find(params[:id])
    @task.update(status: 2)
    redirect_to task_path @task.id
  end
end
