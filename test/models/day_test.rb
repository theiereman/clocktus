require "test_helper"

class DayTest < ActiveSupport::TestCase
  test "percentage_done rounds the filled ratio" do
    day = Day.new(Date.new(2026, 6, 10), false, 3, 8)

    assert_equal 38, day.percentage_done
  end

  test "percentage_done is zero when there are no slots" do
    day = Day.new(Date.new(2026, 6, 10), false, 0, 0)

    assert_equal 0, day.percentage_done
  end

  test "percentage_done is 100 when every slot is filled" do
    day = Day.new(Date.new(2026, 6, 10), true, 8, 8)

    assert_equal 100, day.percentage_done
  end

  test "completed? reflects the completed flag" do
    assert Day.new(Date.new(2026, 6, 10), true, 8, 8).completed?
    assert_not Day.new(Date.new(2026, 6, 10), false, 4, 8).completed?
  end
end
