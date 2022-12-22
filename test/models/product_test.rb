require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should have a positive price" do
    product  = products(:one)
    product.price = -1
    assert_not product.valid?
  end

  test "destroy user when the user is destroy" do
    assert_difference("Product.count", -1) do
      users(:one).destroy
    end
  end
end
