class Room < ApplicationRecord
  belongs_to :order
  belongs_to :user
  belongs_to :home
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :length, presence: true
  validates :width, presence: true
  validates :height, presence: true
  validates :number_room, presence: true
  validates :price, presence: true
  validates :price_unit, presence: true
  validates :status, presence: true
  validates :area, presence: true
end
