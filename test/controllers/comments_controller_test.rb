require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "creates a comment and shows a confirmation toast" do
    assert_difference("Comment.count") do
      post comments_url, params: { comment: { date: "2026-07-01", body: "Went hiking" } }
    end

    assert_response :success
    assert_match "turbo-stream", response.body
    assert_match I18n.t("activities.comment_form.saved"), response.body
    assert_equal "Went hiking", @user.comments.find_by(date: "2026-07-01").body
  end

  test "does nothing when blurring an empty field with no existing comment" do
    assert_no_difference("Comment.count") do
      post comments_url, params: { comment: { date: "2026-07-01", body: "" } }
    end

    assert_response :success
    assert_empty response.body
  end

  test "updates an existing comment and shows a confirmation toast" do
    comment = comments(:one)

    assert_no_difference("Comment.count") do
      post comments_url, params: { comment: { date: comment.date, body: "Updated note" } }
    end

    assert_response :success
    assert_match I18n.t("activities.comment_form.saved"), response.body
    assert_equal "Updated note", comment.reload.body
  end

  test "clearing an existing comment deletes it and shows a confirmation toast" do
    comment = comments(:one)

    assert_difference("Comment.count", -1) do
      post comments_url, params: { comment: { date: comment.date, body: "" } }
    end

    assert_response :success
    assert_match I18n.t("activities.comment_form.deleted"), response.body
    assert_not Comment.exists?(comment.id)
  end
end
