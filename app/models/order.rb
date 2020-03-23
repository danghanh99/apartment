class Order < ApplicationRecord
  belongs_to :user
  belongs_to :home
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :home_id, presence: true
  validates :checkin_time, presence: true
  validate :checkin_time_cannot_be_in_the_past
  validates :rental_period, presence: true
  enum order_status: { requesting: "requesting", approved: "approved", deny: "deny", finished: "finished", requesting_extension: "requesting extension", approved_extension: "approved extension", deny_extension: "deny extension" }
  validates :order_status, presence: true, inclusion: { in: %w(requesting approved finished deny requesting_extension deny_extension approved_extension) }

  def self.allowed_rental_duration
    [1, 3, 6, 12]
  end

  def checkin_time_cannot_be_in_the_past
    if checkin_time.present? && checkin_time.past?
      errors.add(:checkin_time, "can't be in the past")
    end
  end
end
