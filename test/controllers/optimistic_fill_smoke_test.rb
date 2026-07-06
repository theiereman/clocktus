require "test_helper"

class OptimisticFillSmokeTest < ActionDispatch::IntegrationTest
  setup { sign_in users(:one) }

  test "day view emits optimistic fill hooks" do
    get activities_url
    assert_response :success
    assert_select ".grid[data-controller~=?][data-optimistic-fill-slot-seconds-value][data-optimistic-fill-cursor-value][data-optimistic-fill-day-end-value]", "optimistic-fill"
    assert_select "form[data-optimistic-fill-color][data-optimistic-fill-label]"
    assert_select "[data-optimistic-slot-start]"
    assert_select "[data-optimistic-label]"
  end

  test "optimistic create fills the offset slot and returns no content" do
    user = users(:one)
    category = activity_categories(:one)
    duration = user.activity_duration_in_minutes
    base = user.snap_to_activity_slot(Time.zone.parse("2026-06-10 09:00:00"))

    assert_difference("Activity.count") do
      post activities_url, params: {
        activity: { started_at: "2026-06-10 09:00:00", activity_category_id: category.id },
        slot_offset: 3, optimistic: "1"
      }
    end
    assert_response :no_content
    assert_equal base + (3 * duration).minutes, Activity.order(:created_at).last.started_at
  end

  test "failed create returns 422 so turbo reports failure" do
    post activities_url, params: { activity: { started_at: "2026-06-10 09:00:00", activity_category_id: 0 } }
    assert_response :unprocessable_entity
  end

  test "index reconciles from an epoch datetime" do
    ts = Time.zone.parse("2026-06-10 09:00:00").to_i
    get activities_url(datetime: ts)
    assert_response :success
    assert_select "turbo-frame#activities[data-current-timestamp=?]", ts.to_s
  end
end
