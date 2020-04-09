class Order < ApplicationRecord
  belongs_to :user
  belongs_to :home, optional: true
  belongs_to :room, optional: true

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :checkin_time, presence: true
  validate :checkin_time_cannot_be_in_the_past
  validates :rental_period, presence: true
  enum order_type: { order_new: "order_new", order_extion: "order_extion" }
  validates :order_type, presence: true,
                         inclusion: { in: %w(order_new order_extion) }
  enum status: { requesting: "requesting", editted: "editted", approved: "approved", denied: "denied",
                 cancelled: "cancelled", finished: "finished", requesting_extension: "requesting_extension" }
  validates :status, presence: true,
                     inclusion: { in: %w(requesting approved denied cancelled finished requesting_extension) }
  validate :home_id_or_room_id_have_to_present

  def self.allowed_rental_duration
    [1, 3, 6, 12]
  end

  def home_id_or_room_id_have_to_present
    if home_id.blank? && room_id.blank?
      errors.add("home_id or room_id have to present")
    end
  end

  def checkin_time_cannot_be_in_the_past
    if checkin_time.present? && checkin_time.past?
      errors.add(:checkin_time, "can't be in the past")
    end
  end

  def self.cancel(params, check)
    @order = Order.find_by(id: params[:order_id])
    if @order.requesting?
      @home.available! if @home.present?
      @room.available! if @room.present?
      @order.cancelled!
      check = true
    end
    check
  end
  def self.approve(params)
    @order = Order.find_by(id: params[:order_id])
    if @order.requesting? || @order.requesting_extension?
      @home = @order.home
      @room = @order.room
      @home.rented! if @home.present?
      @room.rented! if @room.present?
      @order.update status: "approved"
    end
    @order
  end

  def self.deny(params)
    @order = Order.find_by(id: params[:order_id])
    if @order.requesting? || @order.requesting_extension?
      @home = @order.home
      @room = @order.room
      @order.denied!
      @order.order_type == "order_new" ? (@home.available! if @home.present? @room.available! if @room.present?) : (@home.rented! if @home.present? @room.rented! if @room.present?)
    end
    @order
  end
  def self.finish(params, check)
    @order = Order.find_by(id: params[:order_id])
    unless @order.finished? || @order.cancelled?
      @home = @order.home
      @room = @order.room
      @home.available! if @home.present?
      @room.available! if @room.present?
      @order.finished!
      check = true
    end
    check
  end
  def self.search(params, id)
    @user = User.find_by(id: id)
    @orders = @user.orders
    @orders = Order.all if @user.admin?
    results = @orders
    results = @orders.where("status LIKE :search", search: "#{params[:search_order]}") if params[:search_order].present?
    results
  end

  def self.check_order_extension(id)
    Order.select { |order| order.relation == "#{id}" && (order.approved? || order.requesting?) }.blank?
  end

  def self.find_order_extension(id)
    Order.select { |order| order.relation == "#{id}" }
  end
end
