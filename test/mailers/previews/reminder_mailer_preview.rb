# Preview all emails at http://localhost:3000/rails/mailers/reminder_mailer
class ReminderMailerPreview < ActionMailer::Preview
  def fill_reminder
    ReminderMailer.fill_reminder(User.first)
  end
end
