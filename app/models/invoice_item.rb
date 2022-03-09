class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  validates :item_id, presence: true, numericality: true
  validates :invoice_id, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  validates :quantity, presence: true, numericality: true

  enum status: { pending: 0, packaged: 1, shipped: 2 }

  before_validation :integer_status

  def change_status(result)
    pending! if result == 'pending'
    packaged! if result == 'packaged'
    shipped! if result == 'shipped'
  end

  def self.discount_revenue
    if joins(:bulk_discounts).pluck(:threshold).first <= all.first.quantity
    # if joins(:bulk_discounts).pluck(:threshold).first <= all.sum(:quantity)
      discount = joins(:bulk_discounts).order(discount_percent: :desc).pluck(:discount_percent).first / 100.0
      total_revenue = sum('invoice_items.unit_price * invoice_items.quantity')
      disc_rev = total_revenue - (total_revenue * discount)
    else
      sum('invoice_items.unit_price * invoice_items.quantity')
    end
  end

  private

  def integer_status
    self.status = 0 if status == 'pending'
    self.status = 1 if status == 'packaged'
    self.status = 2 if status == 'shipped'
  end
end
