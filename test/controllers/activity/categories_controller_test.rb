require "test_helper"

class Activity::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @activity_category = activity_categories(:one)
  end

  test "should create activity_category" do
    assert_difference("Activity::Category.count") do
      post activity_categories_url, params: { activity_category: { label: @activity_category.label, user_id: @activity_category.user_id } }
    end

    assert_redirected_to settings_path
  end

  test "should update activity_category" do
    patch activity_category_url(@activity_category), params: { activity_category: { label: @activity_category.label, user_id: @activity_category.user_id } }
    assert_redirected_to settings_path
  end

  test "should destroy activity_category" do
    Activity.where(activity_category_id: @activity_category.id).delete_all
    assert_difference("Activity::Category.count", -1) do
      delete activity_category_url(@activity_category)
    end

    assert_redirected_to settings_path
  end

  test "destroying a category with activities renders the transfer modal without deleting" do
    assert_no_difference([ "Activity::Category.count", "Activity.count" ]) do
      delete activity_category_url(@activity_category)
    end

    assert_response :success
    assert_match "transfer-activities-modal", @response.body
  end
end
