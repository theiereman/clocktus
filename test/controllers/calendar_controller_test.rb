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
end
