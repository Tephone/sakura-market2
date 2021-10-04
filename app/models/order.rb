class Order < ApplicationRecord
  belongs_to :user
  belongs_to :seller
  belongs_to :delivery_time
  has_many :ordered_products, dependent: :destroy
end
