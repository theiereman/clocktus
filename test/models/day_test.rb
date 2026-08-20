require "test_helper"

class DayTest < ActiveSupport::TestCase
  test "percentage_done rounds the filled ratio" do
    day = Day.new(Date.new(2026, 6, 10), 3, 8)

    assert_equal 38, day.percentage_done
  end

  test "percentage_done is zero when there are no slots" do
    day = Day.new(Date.new(2026, 6, 10), 0, 0)

    assert_equal 0, day.percentage_done
  end

  test "percentage_done is 100 when every slot is filled" do
    day = Day.new(Date.new(2026, 6, 10), 8, 8)

    assert_equal 100, day.percentage_done
  end

  test "completed? reflects whether every slot is filled" do
    assert Day.new(Date.new(2026, 6, 10), 8, 8).completed?
    assert_not Day.new(Date.new(2026, 6, 10), 4, 8).completed?
  end

  test "mood defaults to nil" do
    assert_nil Day.new(Date.new(2026, 6, 10), 4, 8).mood
  end

  test "mood returns the mood given at initialization" do
    mood = Mood.new(level: :great)

    assert_equal mood, Day.new(Date.new(2026, 6, 10), 4, 8, mood).mood
  end
end
