class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :name
  validates_presence_of :percent_discounted
  validates_presence_of :quantity_threshold
end
