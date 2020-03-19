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
  validates :rental_period, presence: true
  enum order_status: { requesting: "requesting", approved: "approved" }
  validates :order_status, presence: true, inclusion: { in: %w(requesting approved) }

  def self.allowed_rental_duration
    [1, 3, 6, 12]
  end
end
