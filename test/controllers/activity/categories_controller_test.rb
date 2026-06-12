require "test_helper"

class Activity::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity_category = activity_categories(:one)
  end

  test "should get index" do
    get activity_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_activity_category_url
    assert_response :success
  end

  test "should create activity_category" do
    assert_difference("Activity::Category.count") do
      post activity_categories_url, params: { activity_category: { activity_id: @activity_category.activity_id, label: @activity_category.label, user_id: @activity_category.user_id } }
    end

    assert_redirected_to activity_category_url(Activity::Category.last)
  end

  test "should show activity_category" do
    get activity_category_url(@activity_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_activity_category_url(@activity_category)
    assert_response :success
  end

  test "should update activity_category" do
    patch activity_category_url(@activity_category), params: { activity_category: { activity_id: @activity_category.activity_id, label: @activity_category.label, user_id: @activity_category.user_id } }
    assert_redirected_to activity_category_url(@activity_category)
  end

  test "should destroy activity_category" do
    assert_difference("Activity::Category.count", -1) do
      delete activity_category_url(@activity_category)
    end

    assert_redirected_to activity_categories_url
  end
end
