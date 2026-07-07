require "test_helper"

class NavigationHelperTest < ActiveSupport::TestCase
  include NavigationHelper
  include Rails.application.routes.url_helpers

  test "navigation_items lists the four main sections in order" do
    items = navigation_items

    assert_equal [ activities_path, calendar_path, statistics_path, settings_path ], items.map { |i| i[:path] }
    assert_equal [ 0, 1, 2, 3 ], items.map { |i| i[:nav_index] }
  end

  test "current_nav_index matches the current path" do
    Current.path = calendar_path

    assert_equal 1, current_nav_index
  end

  test "current_nav_index is nil when the current path is not a nav item" do
    Current.path = "/some/other/path"

    assert_nil current_nav_index
  end
end
