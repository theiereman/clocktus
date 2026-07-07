class SendFillRemindersJob < ApplicationJob
  queue_as :default

  def perform(now = Time.current)
    User.find_each do |user|
      next unless user.reminder_due?(now)

      ReminderMailer.fill_reminder(user).deliver_later
    end
  end
end
