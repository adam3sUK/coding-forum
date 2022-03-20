require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "shoud not save user without params" do
    user = User.new
    assert_not user.save
  end
  # test "the truth" do
  #   assert true
  # end
end
