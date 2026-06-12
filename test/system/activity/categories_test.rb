require "application_system_test_case"

class Activity::CategoriesTest < ApplicationSystemTestCase
  setup do
    @activity_category = activity_categories(:one)
  end

  test "visiting the index" do
    visit activity_categories_url
    assert_selector "h1", text: "Categories"
  end

  test "should create category" do
    visit activity_categories_url
    click_on "New category"

    fill_in "Activity", with: @activity_category.activity_id
    fill_in "Label", with: @activity_category.label
    fill_in "User", with: @activity_category.user_id
    click_on "Create Category"

    assert_text "Category was successfully created"
    click_on "Back"
  end

  test "should update Category" do
    visit activity_category_url(@activity_category)
    click_on "Edit this category", match: :first

    fill_in "Activity", with: @activity_category.activity_id
    fill_in "Label", with: @activity_category.label
    fill_in "User", with: @activity_category.user_id
    click_on "Update Category"

    assert_text "Category was successfully updated"
    click_on "Back"
  end

  test "should destroy Category" do
    visit activity_category_url(@activity_category)
    click_on "Destroy this category", match: :first

    assert_text "Category was successfully destroyed"
  end
end
