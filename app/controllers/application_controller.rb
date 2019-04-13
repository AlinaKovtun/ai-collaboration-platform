# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def welcome
    render html: helpers.tag.h1('Welcome to the internet!')
  end
end
