require "test_helper"

class SendFillRemindersJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper
  test "delivers a reminder only to users whose reminder is due" do
    due_user = users(:one)
    due_user.update!(reminder_enabled: true, reminder_hour: 18, reminder_frequency: "daily")

    other_user = users(:two)
    other_user.update!(reminder_enabled: false)

    assert_enqueued_email_with ReminderMailer, :fill_reminder, args: [ due_user ] do
      SendFillRemindersJob.perform_now(Time.zone.local(2026, 7, 7, 18))
    end
  end

  test "delivers nothing when no reminder is due" do
    users(:one).update!(reminder_enabled: true, reminder_hour: 9, reminder_frequency: "daily")

    assert_no_enqueued_emails do
      SendFillRemindersJob.perform_now(Time.zone.local(2026, 7, 7, 18))
    end
  end
end
