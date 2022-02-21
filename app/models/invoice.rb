class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :transactions
  validates :customer_id, presence: true
  validates :status, presence: true

  enum status: {'in progress' => 0, completed: 1, cancelled: 2}

  before_validation :integer_status
  def created_at_date
    self.created_at.strftime("%A, %B %d, %Y")
  end

  def total_revenue
    self.invoice_items.sum(:unit_price)
  end

  private
  def integer_status
    self.status = 0 if self.status == 'in progress'
    self.status = 1 if self.status == 'completed'
    self.status = 2 if self.status == 'cancelled'
  end
end
