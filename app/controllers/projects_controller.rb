# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :find_project, only: %i[edit update destroy]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params.merge(author_id: current_user.id))

    if @project.save
      redirect_to @project, notice: t('.notice')
    else
      render :new, alert: t('.alert')
    end
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: t('.notice')
    else
      render :edit, alert: t('.alert')
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path, notice: t('.notice')
    else
      redirect_to projects_path, alert: t('.alert')
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :image)
  end

  def find_project
    @project = current_user.owned_projects.find(params[:id])
  end
end
