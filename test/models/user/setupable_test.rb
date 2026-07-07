require "test_helper"

class User::SetupableTest < ActiveSupport::TestCase
  test "reminder is not due when disabled" do
    user = users(:one)
    user.update!(reminder_enabled: false, reminder_hour: 18, reminder_frequency: "daily")

    assert_not user.reminder_due?(Time.zone.local(2026, 7, 7, 18))
  end

  test "daily reminder is due at the configured hour" do
    user = users(:one)
    user.update!(reminder_enabled: true, reminder_hour: 18, reminder_frequency: "daily")

    assert user.reminder_due?(Time.zone.local(2026, 7, 7, 18))
    assert_not user.reminder_due?(Time.zone.local(2026, 7, 7, 17))
  end

  test "weekly reminder is due only on mondays" do
    user = users(:one)
    user.update!(reminder_enabled: true, reminder_hour: 9, reminder_frequency: "weekly")

    assert user.reminder_due?(Time.zone.local(2026, 7, 6, 9)) # monday
    assert_not user.reminder_due?(Time.zone.local(2026, 7, 7, 9)) # tuesday
  end

  test "monthly reminder is due only on the first of the month" do
    user = users(:one)
    user.update!(reminder_enabled: true, reminder_hour: 9, reminder_frequency: "monthly")

    assert user.reminder_due?(Time.zone.local(2026, 7, 1, 9))
    assert_not user.reminder_due?(Time.zone.local(2026, 7, 2, 9))
  end

  test "reminder frequency must be valid when enabled" do
    user = users(:one)
    user.reminder_enabled = true
    user.reminder_frequency = "hourly"

    assert_not user.valid?
    assert_includes user.errors.attribute_names, :reminder_frequency
  end
end
