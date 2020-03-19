require "test_helper"

class OrderTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @home = homes(:a0)
    @order = @home.orders.build(name: "manh hung", address: "ngo sy lien", order_status: "requesting",
                                phone_number: 19001099, checkin_time: "2020-03-19 14:00:00 UTC", rental_period: 3, user_id: @user.id, home_id: @home_id)
  end

  test "should be valid" do
    assert @order.valid?
  end
end
