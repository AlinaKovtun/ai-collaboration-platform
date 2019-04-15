# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  include AbstractController::Callbacks
  before_action :add_inline_attachment!

  private

  def add_inline_attachment!
    image = Rails.root.join('app/assets/images/brand.png')
    attachments.inline['brand.png'] = File.read(image)
  end
end
