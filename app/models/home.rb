class Home < ApplicationRecord
  has_many :orders, dependent: :destroy
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
  validates :address, presence: true, length: { minimum: 5, maximum: 250 }

  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

  def self.search(params)
    results = Home.all
    results = results.where("lower(name) LIKE :search", search: "%#{params[:search_home]}%") if params[:search_home].present?
    results = results.where("lower(status) LIKE :search", search: "%#{params[:home_status]}%") if params[:home_status].present?
    results = results.where("number_floors < ?", params[:number_floors]) if params[:number_floors].present?
    results = results.where("full_price > ?", params[:price_begin]) if params[:price_begin].present?
    results = results.where("full_price < ?", params[:price_end]) if params[:price_end].present?
    results
  end
end
