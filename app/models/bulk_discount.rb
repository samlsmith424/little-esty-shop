class BulkDiscount < ApplicationRecord
  validates_presence_of :discount_percent, :threshold
  validates_numericality_of :discount_percent, :threshold

  belongs_to :merchant
end
