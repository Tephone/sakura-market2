class Product < ApplicationRecord
  belongs_to :seller
  has_many :ordered_products, dependent: :destroy
  mount_uploader :image, ImageUploader
  validates :name, presence: true
  validates :price, presence: true
  validates :stock, numericality: { only_integer: true, greater_than_equal_to: 0 }

  def refresh_stock(stock)
    self.stock += stock.to_i
  end
end
