require "test_helper"

class HomesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @home = homes(:one)
    @user = users(:michael)
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Home.count" do
      post homes_path, params: { home: { name: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Home.count" do
      delete home_path(@home)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    home = homes(:two)
    assert_no_difference "Home.count" do
      delete home_path(home)
    end
    assert_redirected_to root_url
  end

  test "successful create home" do
    log_in_as(users(:michael))
    assert_difference "Home.count", 1 do
      post homes_path, params: { home: { name: "home test",
                                        status: "available",
                                        number_floors: 2,
                                        full_price: 5000000 } }
    end
  end

  test "unsuccessful create home" do
    log_in_as(users(:michael))
    assert_no_difference "Home.count" do
      post homes_path, params: { home: { name: "",
                                        status: "available",
                                        number_floors: 2,
                                        full_price: 5000000 } }
    end
    assert_template "users/show"
  end

  test "successful delete home" do
    log_in_as(users(:michael))
    assert_difference "Home.count", -1 do
      delete home_path(@home)
    end
    assert_redirected_to @user
    assert_not flash.empty?
  end
  test "successful edit home" do
    log_in_as(users(:michael))
    assert_no_difference "Home.count" do
      get edit_home_path(@home)
    end
  end
  test "successful update home" do
    log_in_as(users(:michael))
    assert_no_difference "Home.count" do
      get edit_home_path(@home)
      patch home_path, params: { home: { name: "home test",
                                        status: "available",
                                        number_floors: 2,
                                        full_price: 5000000 } }
    end
    assert_redirected_to @user
    assert_not flash.empty?
  end

  test "unsuccessful update home" do
    log_in_as(users(:michael))
    assert_no_difference "Home.count" do
      get edit_home_path(@home)
      patch home_path, params: { home: { name: "",
                                        status: "available",
                                        number_floors: 2,
                                        full_price: 5000000 } }
    end
    assert_template "edit"
  end

  test "successful search home" do
    assert_no_difference "Home.count" do
      get search_path,
          params: { search_home: "available" }
      assert_select ".name", 3
      assert_select ".status", 3
    end
  end
end
