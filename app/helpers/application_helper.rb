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
    price_symbol = "VND"
    if price_unit == "USD"
      price_symbol = "$"
      " #{price_symbol}#{price}"
    else
      " #{price}#{price_symbol}"
    end
  end
end
