class Room < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :user
  belongs_to :home
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :length, presence: true
  validates :width, presence: true
  validates :height, presence: true
  validates :number_room, presence: true
  validates :price, presence: true
  enum price_unit: { VND: "VND", USD: "USD" }
  validates :price_unit, presence: true, inclusion: { in: %w(VND USD) }
  validates :area, presence: true
  enum status: { available: "available", ordered: "ordered", rented: "rented" }
  validates :status, presence: true, inclusion: { in: %w(available ordered rented) }

  def type_name
    "room"
  end
end
