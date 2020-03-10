class Home < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id,       presence: true
  enum status: { order: 0, using: 1, empty: 2 }, _prefix: :type
  validates :status,        presence: true, length: { maximum: 250 }
  validates :name,          presence: true, length: { maximum: 100 }
  validates :price,         presence: true, 
                            numericality: { only_integer: true }
  validates :number_floors, presence: true, 
                            numericality: { only_integer: true }
  validate  :picture_size
  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end