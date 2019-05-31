# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[edit update destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render 'edit'
  end
end

  private

  def task_params
    params.require(:task).permit(:title, :short_information, :completed)
  end

  def find_task
    @task = Task.find(params[:id])
  end

end
