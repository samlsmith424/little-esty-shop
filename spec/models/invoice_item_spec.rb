require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :quantity }

    it { should validate_numericality_of :item_id }
    it { should validate_numericality_of :invoice_id }
    it { should validate_numericality_of :unit_price }
    it { should validate_numericality_of :quantity }
  end

  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_one(:merchant).through(:item) }
    it { should have_many(:bulk_discounts).through(:merchant) }
  end

  describe 'instance methods' do
    describe 'change_status(result)' do
      it 'can change status of invoice item' do
        invoice_item_1 = create(:invoice_item, status: 'pending')
        expect(invoice_item_1.status).to eq('pending')
        invoice_item_1.change_status('packaged')
        expect(invoice_item_1.status).to eq('packaged')
      end
    end

    it 'shows total discounted revenue' do
      merchant_1 = create(:merchant)
      customer_1 = create(:customer)
      bulk_disc_1 = create(:bulk_discount, merchant_id: merchant_1.id, threshold: 5, discount_percent: 20 )
      item_1 = create(:item, merchant_id: merchant_1.id)
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1, quantity: 5)

      expect(merchant_1.invoice_items.discount_revenue).to eq(4.0)
    end

    it 'shows no total discounted revenue if items and quantity do not meet criteria' do
      merchant_1 = create(:merchant)
      customer_1 = create(:customer)
      bulk_disc_1 = create(:bulk_discount, merchant_id: merchant_1.id, threshold: 5, discount_percent: 20 )
      item_1 = create(:item, merchant_id: merchant_1.id)
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1, quantity: 3)

      expect(merchant_1.invoice_items.discount_revenue).to eq(3.0)
    end

    it 'shows no total discounted revenue if items separately are not enough to meet the threshold' do
      merchant_1 = create(:merchant)
      customer_1 = create(:customer)
      bulk_disc_1 = create(:bulk_discount, merchant_id: merchant_1.id, threshold: 5, discount_percent: 20 )
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_1.id)
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1, quantity: 3)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: 1, quantity: 2)

      expect(merchant_1.invoice_items.discount_revenue).to eq(5.0)
    end

    it 'returns the larger discount applied' do
      merchant_1 = create(:merchant)
      customer_1 = create(:customer)
      bulk_disc_1 = create(:bulk_discount, merchant_id: merchant_1.id, threshold: 5, discount_percent: 20 )
      bulk_disc_2 = create(:bulk_discount, merchant_id: merchant_1.id, threshold: 5, discount_percent: 50 )
      item_1 = create(:item, merchant_id: merchant_1.id)
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1, quantity: 5)

      expect(merchant_1.invoice_items.discount_revenue).to eq(2.5)
    end

    xit 'returns the bulk discount for the applicable item' do
      merchant_1 = create(:merchant)
      customer_1 = create(:customer)
      bulk_disc_1 = create(:bulk_discount, merchant_id: merchant_1.id, threshold: 5, discount_percent: 20 )
      item_1 = create(:item, merchant_id: merchant_1.id)
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      item_2 = create(:item, merchant_id: merchant_1.id)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1, quantity: 3)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: 1, quantity: 10)

      expect(merchant_1.invoice_items.discount_revenue).to eq(11)
    end
  end
end
