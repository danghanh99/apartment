class Home < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  enum status: { available: "available", ordered: "ordered", rented: "rented" }
  validates :status, presence: true, inclusion: { in: %w(available ordered rented) }
  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :full_price, presence: true,
                         numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :number_floors, presence: true,
                            numericality: { only_integer: true, greater_than: 0 }
  validate :picture_size
  enum price_unit: { VND: "VND", USD: "USD" }
  validates :price_unit, presence: true, inclusion: { in: %w(VND USD) }

  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

  def self.search(search_home, number_floors, price_begin, price_end)
    results = Home.all
    results = Home.where("lower(name) LIKE :search OR lower(status) LIKE :search", search: "%#{search_home}%") if search_home.present?
    results = Home.where("number_floors < ?", number_floors) if number_floors.present?
    results = Home.where("full_price > ?", price_begin) if price_begin.present?
    results = Home.where("full_price < ?", price_end) if price_end.present?
    results
  end
end
