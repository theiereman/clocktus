require "test_helper"

class CalendarControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in users(:one) }

  test "requires authentication" do
    reset!
    get calendar_url

    assert_redirected_to new_session_url
  end

  test "renders the calendar for the current month by default" do
    get calendar_url

    assert_response :success
  end

  test "renders the calendar for a given month" do
    get calendar_url, params: { date: "2026-06-15" }

    assert_response :success
  end

  test "falls back to the current month when the date is invalid" do
    get calendar_url, params: { date: "not-a-date" }

    assert_response :success
  end

  test "shows the mood icon on a day that has a mood recorded" do
    users(:one).moods.create!(date: Date.new(2026, 6, 10), level: :great)

    get calendar_url, params: { date: "2026-06-15" }

    assert_response :success
    assert_select "a[href*='date=2026-06-10'] svg", 1
  end

  test "does not show a mood icon on a day without a mood recorded" do
    get calendar_url, params: { date: "2026-06-15" }

    assert_response :success
    assert_select "a[href*='date=2026-06-10'] svg", 0
  end
end
