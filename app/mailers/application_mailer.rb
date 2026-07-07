class ApplicationMailer < ActionMailer::Base
  default from: "Clocktus <contact@clocktus.com>"
  layout "mailer"
  helper MailerHelper

  before_action :attach_logo

  private

  def attach_logo
    attachments.inline["flower.png"] = Rails.root.join("app/assets/images/flower.png").read
  end
end
