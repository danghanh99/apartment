class Order < ApplicationRecord
  belongs_to :user
  belongs_to :home
  default_scope -> { order(created_at: :desc) }
end
