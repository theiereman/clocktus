require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "renders the landing page for unauthenticated visitors" do
    get root_path

    assert_response :success
    assert_select "html[lang=?]", "en"
    assert_select "link[rel=canonical]"
    assert_select "link[rel=alternate][hreflang=fr]"
  end

  test "renders the landing page in french on /fr" do
    get root_path(locale: :fr)

    assert_response :success
    assert_select "html[lang=?]", "fr"
  end

  test "redirects authenticated users to the app" do
    sign_in users(:one)

    get root_path

    assert_redirected_to activities_path
  end
end
