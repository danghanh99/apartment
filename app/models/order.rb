class Order < ApplicationRecord
  belongs_to :user
  belongs_to :home, optional: true
  belongs_to :room, optional: true

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :checkin_time, presence: true
  validate :checkin_time_cannot_be_in_the_past
  validates :rental_period, presence: true
  enum order_status: { requesting: "requesting", approved: "approved", deny: "deny", cancel: "cancel", finished: "finished", requesting_extension: "requesting_extension", approved_extension: "approved_extension", deny_extension: "deny_extension" }
  validates :order_status, presence: true, inclusion: { in: %w(requesting approved deny cancel finished requesting_extension deny_extension approved_extension) }
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

  def self.cancel(params)
    @order = Order.find_by(id: params[:order_id])
    if @order.order_status == "requesting" || @order.order_status == "deny" || @order.order_status == "finished"
      @home.available! if @home.present?
      @room.available! if @room.present?
      @order.cancel!
    end
    @order
  end
  def self.approved(params)
    @order = Order.find_by(id: params[:order_id])
    @home = @order.home
    @room = @order.room
    @home.rented! if @home.present?
    @room.rented! if @room.present?
    @order.update order_status: "approved"
  end

  def self.deny(params)
    @order = Order.find_by(id: params[:order_id])
    @home = @order.home
    @room = @order.room
    @home.available! if @home.present?
    @room.rented! if @room.present?
    @order.deny!
  end

  def self.order_home_count(status)
    home = Order.where("home_id IS NOT NULL")
    home_count = home.where("lower(order_status) LIKE :search", search: "#{status}").count
    home_count
  end

  def self.order_room_count(status)
    room = Order.where("room_id IS NOT NULL")
    room_count = room.where("lower(order_status) LIKE :search", search: "#{status}").count
    room_count
  end

  def self.search_order(params)
    results = Order.all
    results = Order.where("lower(order_status) LIKE :search", search: "#{params[:search_order]}") if params[:search_order].present?
    results
  end
end
