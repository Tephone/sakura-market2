class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :seller
  has_many :ordered_products, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
  validates :stock, numericality: { only_integer: true, greater_than_equal_to: 0}
  
  def total_stock(stock)
    stock = stock.to_i 
    total_stock = self.stock + stock
  end
end
