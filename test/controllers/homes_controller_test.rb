require 'test_helper'

class HomesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @home = homes(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Home.count' do
      post homes_path, params: { home: { name: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Home.count' do
      delete home_path(@home)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    home = homes(:one)
    assert_no_difference 'Home.count' do
      delete home_path(home)
    end
    assert_redirected_to root_url
  end

end
