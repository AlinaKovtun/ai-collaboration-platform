# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def welcome
    render html: helpers.tag.h1('Welcome to the internet!')
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :description, :email, :password)
    end
  end
end
