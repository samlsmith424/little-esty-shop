require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it {should validate_presence_of :customer_id}
  it {should validate_presence_of :status}
  it {should have_many :invoice_items}
  it {should have_many :transactions}
  it {should belong_to :customer}

  describe 'instance methods' do
    it 'can reformat the created_at timestamp' do
      invoice_1 = create(:invoice, created_at: Time.parse("2022-02-22"))

      expect(invoice_1.created_at_date).to eq("Tuesday, February 22, 2022")
    end

    it 'can calculate the total revenue of each merchant' do
      merchant_1 = create(:merchant)
      customer_1 = create(:customer)
      item_1 = create(:item, merchant_id: merchant_1.id)
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 3)

      item_2 = create(:item, merchant_id: merchant_1.id)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: 5)

      item_3 = create(:item, merchant_id: merchant_1.id)
      invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_1.id, unit_price: 4)

      expect(invoice_1.total_revenue).to eq(12)
    end
  end
end
