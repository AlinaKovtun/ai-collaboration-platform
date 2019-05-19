# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[edit update destroy]
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_event_subscribe, only: %i[subscribe unsubscribe]

  def index
    @events = Event.upcoming_events
  end

  def show
    @event = Event.find(params[:id])
    @next_events = Event.next_events(@event)
  end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to events_path, notice: t('.notice')
    else
      render 'new', alert: t('.alert')
    end
  end

  def subscribe
    @event.participants << current_user
    redirect_to event_path(@event), notice: t('.notice_yes')
  end

  def unsubscribe
    @event.participants.delete(current_user.id)
    redirect_to event_path(@event), notice: t('.notice_no')
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: t('.notice')
    else
      render 'edit', alert: t('.alert')
    end
  end

  def destroy
    if @event.destroy
      redirect_to events_path, notice: t('.notice')
    else
      redirect_to events_path, alert: t('.alert')
    end
  end

  def user_events
    @user = User.find(params[:id])
    @events = Event.where(user_id: params[:id]).paginate(page: params[:page], per_page: 6)
  end

  private

  def set_event
    @event = current_user.created_events.find(params[:id])
  end

  def set_event_subscribe
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :venue, :event_start,
                                  :event_end, :cost)
  end
end
