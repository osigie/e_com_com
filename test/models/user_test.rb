require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "user with a valid email is valid" do
    user = User.new(email: "test@test.org", password_digest:"test")
    assert user.valid?
  end

  test "user with an invalid email should be invalid" do
    user = User.new(email: "test", password_digest:"test")
    assert_not user.valid?
  end

  test "user with taken email should be invalid" do
    other_user = users(:one)
    user = User.new(email: other_user.email, password_digest:"test")
    assert_not user.valid?
  end
end
