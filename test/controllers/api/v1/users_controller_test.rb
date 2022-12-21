require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do
    @user = users(:one)
  end

  test "should show user" do
    get api_v1_user_url(@user), as: :json
    assert_response :success
    # test to ensure response contain the correct email
    json_response = JSON.parse(self.response.body)
    assert_equal(@user.email, json_response["email"], "email is invalid")
  end
end
