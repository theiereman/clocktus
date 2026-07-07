require "test_helper"

class StatisticsControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in users(:one) }

  test "requires authentication" do
    reset!
    get statistics_url

    assert_redirected_to new_session_url
  end

  test "renders the statistics page" do
    get statistics_url

    assert_response :success
  end

  test "renders the statistics page filtered by a date range" do
    get statistics_url, params: { from: "2026-06-01", to: "2026-06-30" }

    assert_response :success
  end

  test "renders the statistics page when filtering on full days only" do
    users(:one).update!(activity_duration_in_minutes: 60)
    24.times { |h| users(:one).activities.create!(started_at: Time.zone.local(2026, 6, 10, h, 0), category: activity_categories(:one)) }

    get statistics_url, params: { from: "2026-06-01", to: "2026-06-30", full_days_only: "1" }

    assert_response :success
  end
end
