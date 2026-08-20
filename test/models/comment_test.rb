require "test_helper"

class CommentTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
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
