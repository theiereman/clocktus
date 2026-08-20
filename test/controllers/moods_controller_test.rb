require "test_helper"

class MoodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "creates a mood and shows a confirmation toast" do
    assert_difference("Mood.count") do
      post moods_url, params: { mood: { date: "2026-07-01", level: "good" } }
    end

    assert_response :success
    assert_match "turbo-stream", response.body
    assert_match I18n.t("activities.mood_form.saved"), response.body
    assert_equal "good", @user.moods.find_by(date: "2026-07-01").level
  end

  test "updates an existing mood and shows a confirmation toast" do
    mood = moods(:one)

    assert_no_difference("Mood.count") do
      post moods_url, params: { mood: { date: mood.date, level: "terrible" } }
    end

    assert_response :success
    assert_match I18n.t("activities.mood_form.saved"), response.body
    assert_equal "terrible", mood.reload.level
  end

  test "shows an error toast when the level is missing" do
    assert_no_difference("Mood.count") do
      post moods_url, params: { mood: { date: "2026-07-01", level: "" } }
    end

    assert_response :success
    assert_match "turbo-stream", response.body
  end
end
