require "test_helper"

class HomeTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @home = @user.homes.build(name: "nha a", status: "available",
                              number_floors: 1, full_price: 800000, user_id: @user.id)
  end

  test "should be valid" do
    assert @home.valid?
  end

  test "price_unit should be present" do
    @home.price_unit = "     "
    assert_not @home.valid?
  end

  test "user id should be present" do
    @home.user_id = nil
    assert_not @home.valid?
  end

  test "name should be present" do
    @home.name = "     "
    assert_not @home.valid?
  end

  test "status should be present" do
    @home.status = "     "
    assert_not @home.valid?
  end

  test "number_floors should be present" do
    @home.number_floors = "     "
    assert_not @home.valid?
  end

  test "number_floors not have text" do
    @home.number_floors = "a"
    assert_not @home.valid?
  end

  test "full_price should be present" do
    @home.full_price = "     "
    assert_not @home.valid?
  end

  test "full_price not have text" do
    @home.full_price = "a"
    assert_not @home.valid?
  end
end
