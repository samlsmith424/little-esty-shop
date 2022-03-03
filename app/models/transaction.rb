class Transaction < ApplicationRecord
  belongs_to :invoice
  validates :credit_card_number, presence: true, numericality: true
  validates :result, presence: true
  validates :invoice_id, presence: true, numericality: true
  enum result: { 'success' => 0, 'failed' => 1 }
  before_validation :integer_result

  private

  def integer_result
    self.result = 0 if result == 'success'
    self.result = 1 if result == 'failed'
  end
end
