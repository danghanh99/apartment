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

  def order_object
    @home.present? ? @home : @room
  end

  def count_status
    @orders_count_status = current_user.admin? ? Order.all : current_user.orders
    @orders_count_status.reorder(:status).group(:status).count
  end

  def format_currency(price, price_unit)
    price_symbol = (price_unit == "USD") ? "$" : "VND"
    (price_symbol == "VND") ? " #{price} #{price_symbol}" : " #{price_symbol}#{price}"
  end

  def options_for_select_search
    [["Requesting", "requesting"],
     ["Requesting extension", "requesting_extension"],
     ["Approved", "approved"],
     ["Denied", "denied"],
     ["Cancelled", "cancelled"],
     ["Finished", "finished"]]
  end
end
