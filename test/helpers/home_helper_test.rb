require "test_helper"

class HomeHelperTest < ActiveSupport::TestCase
  include HomeHelper

  def t(...) = I18n.t(...)

  test "hero_mockup_slots provides a time, color and label for each slot" do
    slots = hero_mockup_slots

    assert slots.any?
    assert(slots.all? { |s| s[:time].present? && s[:color].present? && s[:label].present? })
  end

  test "stats_mockup_categories provides the data each bar needs" do
    categories = stats_mockup_categories

    assert categories.any?
    assert(categories.all? { |c| c[:label].present? && c[:height].present? && c[:percentage].present? })
  end

  test "how_it_works_steps lists three steps with an icon" do
    steps = how_it_works_steps

    assert_equal 3, steps.size
    assert(steps.all? { |s| s[:icon].present? && s[:title].present? && s[:text].present? })
  end

  test "privacy_points lists points with an icon, title and text" do
    points = privacy_points

    assert points.any?
    assert(points.all? { |p| p[:icon].present? && p[:title].present? && p[:text].present? })
  end
end
