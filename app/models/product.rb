class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :seller
  has_many :ordered_products, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
end
