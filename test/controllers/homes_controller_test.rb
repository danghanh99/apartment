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

  test "search should get all home" do
    assert_no_difference "Home.count" do
      get search_path,
          params: { search_home: "", number_floors: "", price_begin: "", price_end: "" }
      assert_select ".name", 6
      assert_select ".status", 6
    end
  end

  test "search should get home have full_price < 2500000" do
    assert_no_difference "Home.count" do
      get search_path,
          params: { search_home: "", number_floors: "", price_begin: "", price_end: 2500000 }
      assert_select ".name", 5
      assert_select ".status", 5
    end
  end

  test "search should get home have full_price > 1500000" do
    assert_no_difference "Home.count" do
      get search_path,
          params: { search_home: "", number_floors: "", price_begin: 1500000, price_end: "" }
      assert_select ".name", 2
      assert_select ".status", 2
    end
  end

  test "search should get home have 500000 <full_price < 2500000" do
    assert_no_difference "Home.count" do
      get search_path,
          params: { search_home: "", number_floors: "", price_begin: 500000, price_end: 2500000 }
      assert_select ".name", 3
      assert_select ".status", 3
    end
  end

  test "search should get home have status: avai" do
    assert_no_difference "Home.count" do
      get search_path,
          params: { search_home: "avai", number_floors: "", price_begin: "", price_end: "" }
      assert_select ".name", 3
      assert_select ".status", 3
    end
  end
end
