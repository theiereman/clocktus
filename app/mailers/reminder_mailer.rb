class ReminderMailer < ApplicationMailer
  def fill_reminder(user)
    @user = user

    I18n.with_locale(@user.locale.presence || I18n.default_locale) do
      mail to: @user.email_address, subject: default_i18n_subject
    end
  end
end
