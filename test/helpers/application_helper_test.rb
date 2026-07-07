require "test_helper"

class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper

  def l(...) = I18n.l(...)

  test "format_hour renders the hour with the :hour format" do
    assert_equal I18n.l(Time.zone.local(2000, 1, 1, 9), format: :hour), format_hour(9)
  end

  test "format_time renders a time with the :time_of_day format" do
    time = Time.zone.local(2026, 6, 10, 14, 30)

    assert_equal I18n.l(time, format: :time_of_day), format_time(time)
  end

  test "contrasted_text_color returns the dark text color on light backgrounds" do
    assert_equal "var(--color-text)", contrasted_text_color("#ffffff")
  end

  test "contrasted_text_color returns the light background color on dark backgrounds" do
    assert_equal "var(--color-background)", contrasted_text_color("#000000")
  end

  test "darken_color darkens each channel by the given amount" do
    assert_equal "#cccccc", darken_color("#ffffff", 0.2)
  end

  test "darken_color defaults to a 20% reduction" do
    assert_equal "#333333", darken_color("#404040")
  end
end
