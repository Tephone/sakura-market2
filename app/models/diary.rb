class Diary < ApplicationRecord
  belongs_to :user

  scope :date_desc, -> { order(date: :desc) }
end
