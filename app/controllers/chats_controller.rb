# frozen_string_literal: true

class ChatsController < ApplicationController
  def index
    @chats = Chat.all
    @users = User.all
  end

  def create
    @chat = current_user.chats.create(chats_params)
    PrivatePub.publish_to('/messages/new', chat: @chat)
  end

  def chats_params
    params.require(:chat).permit(:body, :user_id)
  end
end
