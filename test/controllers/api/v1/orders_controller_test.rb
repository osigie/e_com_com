require "test_helper"

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @order = orders(:one)
  end

  test "should forbid orders for unloggin users " do
    get api_v1_orders_url as: :json
    assert_response :forbidden
  end

  test "should show orders for login users " do
    get api_v1_orders_url, headers:{Authorization: JsonWebToken.encode(user_id:@order.user_id)},as: :json
    assert_response :success
    json_response = JSON.parse(self.response.body)
    assert_equal @order.user.orders.count, json_response["data"].count
  end

  test "should show orders" do
    get api_v1_order_url(@order), headers:{Authorization:JsonWebToken.encode(user_id:@order.user_id)}, as: :json
    assert_response :success
    json_response = JSON.parse(self.response.body)
    includes_product_attr = json_response["included"][0]["attributes"]
    assert_equal @order.products.first.title, includes_product_attr["title"]

  end

end
