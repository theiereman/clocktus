require "test_helper"

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @activity = activities(:one)
  end

  test "should get index" do
    get activities_url
    assert_response :success
  end

  test "should create activity" do
    category = activity_categories(:one)
    assert_difference("Activity.count") do
      post activities_url, params: { activity: { started_at: "2026-06-10 09:00:00", activity_category_id: category.id } }
    end
    assert_redirected_to activities_url(datetime: Activity.last.ended_at)
  end

  test "rendering an alert when the activity is invalid" do
    assert_no_difference("Activity.count") do
      post activities_url, params: { activity: { started_at: "2026-06-10 09:00:00" } }
    end

    assert_response :success
    assert_match "turbo-stream", response.body
  end

  test "should destroy activity" do
    assert_difference("Activity.count", -1) do
      delete activity_url(@activity)
    end

    assert_redirected_to activities_url(datetime: @activity.started_at)
  end

  test "marks a whole night as sleep" do
    assert_difference("Activity.count", users(:one).sleep_hours.count) do
      post mark_night_as_sleep_url(date: "2026-07-01")
    end

    assert_response :redirect
    assert Activity.where(user: users(:one), category: activity_categories(:sommeil_one)).any?
  end

  test "a larger slot absorbs finer activities it overlaps" do
    user = users(:one)
    category = activity_categories(:one)

    user.update!(activity_duration_in_minutes: 30)
    post activities_url, params: { activity: { started_at: "2026-06-10 09:30:00", activity_category_id: category.id } }
    fine_activity = Activity.order(:created_at).last
    assert_equal Time.zone.local(2026, 6, 10, 9, 30), fine_activity.started_at

    user.update!(activity_duration_in_minutes: 60)
    post activities_url, params: { activity: { started_at: "2026-06-10 09:00:00", activity_category_id: category.id } }
    assert_redirected_to activities_url(datetime: Activity.last.ended_at)

    assert_not Activity.exists?(fine_activity.id)
    coarse_activity = Activity.order(:created_at).last
    assert_equal Time.zone.local(2026, 6, 10, 9, 0), coarse_activity.started_at
    assert_equal Time.zone.local(2026, 6, 10, 10, 0), coarse_activity.ended_at
  end

  test "transferring reassigns activities to the target category and deletes the source" do
    source = activity_categories(:one)
    target = activity_categories(:three)
    activity = activities(:one)

    assert_no_difference("Activity.count") do
      post transfer_activities_url, params: { source_category_id: source.id, mode: "transfer", target_category_id: target.id }
    end

    assert_response :success
    assert_match %r{action="redirect".*target="#{settings_path}"}, response.body
    assert_not Activity::Category.exists?(source.id)
    assert_equal target.id, activity.reload.activity_category_id
  end

  test "deleting removes the source category and all its activities" do
    source = activity_categories(:one)

    assert_difference("Activity.count", -1) do
      post transfer_activities_url, params: { source_category_id: source.id, mode: "delete" }
    end

    assert_response :success
    assert_match %r{action="redirect".*target="#{settings_path}"}, response.body
    assert_not Activity::Category.exists?(source.id)
  end
end
