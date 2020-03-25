module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = "")
    base_title = "Apartment"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def format_currency(price, price_unit)
    price_symbol = (price_unit == "USD") ? "$" : "VND"
    (price_symbol == "VND") ? "#{price}#{price_symbol}" : " #{price_symbol}#{price}"
  end

  def options_for_select_home
    ["#{Order.order_home_count("requesting")} requesting",
     "#{Order.order_home_count("approved")} approved",
     "#{Order.order_home_count("deny")} deny",
     "#{Order.order_home_count("cancel")} cancel",
     "#{Order.order_home_count("finished")} finished",
     "#{Order.order_home_count("requesting_extension")} requesting_extension",
     "#{Order.order_home_count("approved_extension")} approved_extension",
     "#{Order.order_home_count("deny_extension")} deny_extension"]
  end

  def options_for_select_room
    ["#{Order.order_room_count("requesting")} requesting",
     "#{Order.order_room_count("approved")} approved",
     "#{Order.order_room_count("deny")} deny",
     "#{Order.order_room_count("cancel")} cancel",
     "#{Order.order_room_count("finished")} finished",
     "#{Order.order_room_count("requesting_extension")} requesting_extension",
     "#{Order.order_room_count("approved_extension")} approved_extension",
     "#{Order.order_room_count("deny_extension")} deny_extension"]
  end
end
