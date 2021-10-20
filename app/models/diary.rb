class Diary < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :date_desc, -> { order(date: :desc) }
end
