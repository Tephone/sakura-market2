class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :default_order, -> { order(id: :desc) }
end
