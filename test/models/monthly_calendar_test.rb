require "test_helper"

class MonthlyCalendarTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @category = activity_categories(:one)
    @date = Date.new(2026, 6, 15)
    @user.update!(activity_duration_in_minutes: 60)
  end

  def calendar
    MonthlyCalendar.new(User::Progress.for_the_month(@user, @date), @date)
  end

  test "days_count matches the number of days in the month" do
    assert_equal 30, calendar.days_count
  end

  test "leading_blank_days_count reflects the first weekday of the month" do
    assert_equal Date.new(2026, 6, 1).cwday - 1, calendar.leading_blank_days_count
  end

  test "builds one Day per day of the month" do
    days = calendar.days

    assert_equal 30, days.size
    assert_equal Date.new(2026, 6, 1), days.first.date
    assert_equal Date.new(2026, 6, 30), days.last.date
  end

  test "a day with every slot filled is marked completed" do
    24.times { |h| @user.activities.create!(started_at: Time.zone.local(2026, 6, 10, h, 0), category: @category) }

    day = calendar.days.find { |d| d.date == Date.new(2026, 6, 10) }

    assert day.completed?
    assert_equal 100, day.percentage_done
  end

  test "a day with no activity is not completed" do
    day = calendar.days.find { |d| d.date == Date.new(2026, 6, 10) }

    assert_not day.completed?
    assert_equal 0, day.percentage_done
  end

  test "completed_activities_count sums the month's activities" do
    july = Date.new(2026, 7, 3)
    3.times { |h| @user.activities.create!(started_at: Time.zone.local(2026, 7, 1, h, 0), category: @category) }

    calendar = MonthlyCalendar.new(User::Progress.for_the_month(@user, july), july)

    assert_equal 3, calendar.completed_activities_count
  end
end
