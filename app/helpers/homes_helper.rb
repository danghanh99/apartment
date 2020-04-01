module HomesHelper
  def home_show(status)
    status != "rented"
  end

  def check_request_date_and_return_date(return_time, request_date)
    request_checkin_time >= checkin_time if request_checkin_time.present? && checkin_time.present?
  end
end
