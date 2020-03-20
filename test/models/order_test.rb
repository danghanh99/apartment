require "test_helper"

class OrderTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @home = homes(:a0)
    @order = @home.orders.build(name: "manh hung", address: "ngo sy lien", order_status: "requesting",
                                phone_number: 19001099, checkin_time: "2020-04-27 14:45:00", rental_period: 3, user_id: @user.id, home_id: @home_id)
  end

  test "should be valid" do
    assert @order.valid?
  end

  test "name should be present" do
    @order.name = " "
    assert_not @order.valid?
  end

  test "address should be present" do
    @order.address = " "
    assert_not @order.valid?
  end

  test "phone number should be present" do
    @order.phone_number = " "
    assert_not @order.valid?
  end
end
