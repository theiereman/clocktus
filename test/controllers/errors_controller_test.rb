require "test_helper"

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "renders each known status code without authentication" do
    ErrorsController::VALID_STATUS_CODES.each do |code|
      get "/#{code}"

      assert_response code.to_i
    end
  end

  test "renders a non-html request as a bare status" do
    get "/404", headers: { "Accept" => "application/json" }

    assert_response :not_found
    assert_empty response.body
  end
end
