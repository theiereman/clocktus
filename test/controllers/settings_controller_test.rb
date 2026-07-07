require "test_helper"

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in users(:one) }

  test "requires authentication" do
    reset!
    get settings_url

    assert_redirected_to new_session_url
  end

  test "renders the settings page" do
    get settings_url

    assert_response :success
  end

  test "updates the user settings and redirects with a notice" do
    patch settings_url, params: { user: { activity_duration_in_minutes: 30, wake_up_hour: 6, sleep_hour: 22, locale: "fr" } }

    assert_redirected_to settings_path
    assert_equal I18n.t("settings.flash.updated"), flash[:notice]

    users(:one).reload
    assert_equal 30, users(:one).activity_duration_in_minutes
    assert_equal "fr", users(:one).locale
  end

  test "rejects an invalid activity duration and redirects with an alert" do
    patch settings_url, params: { user: { activity_duration_in_minutes: 45 } }

    assert_redirected_to settings_path
    assert flash[:alert].present?
    assert_not_equal 45, users(:one).reload.activity_duration_in_minutes
  end
end
