class Order < ApplicationRecord
  belongs_to :user
  belongs_to :home
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { minimum: 2, maximum: 60 }
  validates :address, presence: true, length: { minimum: 5, maximum: 200 }
  validates :phone_number, presence: true,
                           numericality: { only_integer: true }
  validates :user_id, presence: true
  validates :home_id, presence: true
  validates :checkin_time, presence: true
  enum rental_period: { one_month: "1", three_month: "3", six_month: "6", one_year: "12" }
  validates :rental_period, presence: true, inclusion: { in: %w(1 3 6 12) }
  enum order_status: { odering: "ordering", checkout: "checkout" }
  validates :order_status, presence: true, inclusion: { in: %w(ordering checkout) }
end
