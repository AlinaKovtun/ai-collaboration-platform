# frozen_string_literal: true

class ProjectParticipantsController < ApplicationController
  before_action :find_project
  respond_to :js

  def create
    @project_participant = @project.project_participants.build(project_participant_params)

    if @project_participant.save
      flash.now[:notice] = t('.notice')
    else
      flash.now[:alert] = t('.alert')
    end
  end

  def destroy
    @project_participant = ProjectParticipant.find(params[:id])

    if @project_participant.destroy
      flash.now[:notice] = t('.notice')
    else
      flash.now[:alert] = t('.alert')
    end
  end

  private

  def project_participant_params
    params.require(:project_participant).permit(:role_id, :user_id)
  end

  def find_project
    @project = current_user.owned_projects.find(params[:project_id])
  end
end
