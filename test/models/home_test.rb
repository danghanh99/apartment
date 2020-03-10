require 'test_helper'

class HomeTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @home = @user.homes.build(name: "nha a", status: 2,
                      number_floors: 1, price: 800000, user_id: @user.id)
  end

  test "should be valid" do
    assert @home.valid?
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

  test "price should be present" do
    @home.price = "     "
    assert_not @home.valid?
  end

  test "price not have text" do
    @home.price = "a"
    assert_not @home.valid?
  end

end
