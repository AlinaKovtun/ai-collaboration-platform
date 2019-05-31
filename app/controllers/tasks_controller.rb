# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[edit update destroy]
  before_action :find_project
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = @project.tasks.build(task_params)
    if @task.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def destroy
    @task.destroy
    redirect_to @project
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    if @task.update(task_params)
      redirect_to @project
    else
      render 'edit'
  end
end

  private

  def task_params
    params.require(:task).permit(:title, :short_information, :completed, :project_id)
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

end
