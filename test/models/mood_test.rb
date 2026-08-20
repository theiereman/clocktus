require "test_helper"

class MoodTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "a user can only have one mood per date" do
    Mood.create!(user: @user, date: Date.new(2026, 1, 1), level: :great)
    duplicate = Mood.new(user: @user, date: Date.new(2026, 1, 1), level: :good)

    assert_not duplicate.valid?
  end

  test "requires a level" do
    mood = Mood.new(user: @user, date: Date.new(2026, 1, 1), level: nil)

    assert_not mood.valid?
    assert mood.errors.of_kind?(:level, :blank)
  end
end
