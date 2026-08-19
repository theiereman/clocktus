require "test_helper"

class CommentTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "find_or_initialize_for reuses the existing comment for a user and date" do
    existing = comments(:one)

    comment = Comment.find_or_initialize_for(@user, existing.date)

    assert_equal existing.id, comment.id
  end

  test "find_or_initialize_for builds a new unsaved comment when none exists yet" do
    comment = Comment.find_or_initialize_for(@user, Date.new(2026, 1, 1))

    assert_not comment.persisted?
    assert_equal @user, comment.user
  end

  test "a user can only have one comment per date" do
    Comment.create!(user: @user, date: Date.new(2026, 1, 1), body: "First")
    duplicate = Comment.new(user: @user, date: Date.new(2026, 1, 1), body: "Second")

    assert_not duplicate.valid?
  end

  test "requires a body" do
    comment = Comment.new(user: @user, date: Date.new(2026, 1, 1), body: "")

    assert_not comment.valid?
    assert comment.errors.of_kind?(:body, :blank)
  end
end
