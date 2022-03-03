require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe 'validations' do 
    it {should validate_presence_of :first_name}
    it {should validate_presence_of(:last_name)}
  end

  describe 'relationships' do 
    it {should have_many :invoices}
    it {should have_many(:invoice_items).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'class methods' do 
    describe '#top_customers(count)' do 
      it 'will return the top customers' do 
        customer_1 = create(:customer, first_name: 'Aaron', last_name: 'Adams')
        customer_2 = create(:customer, first_name: 'Barry', last_name: 'Bonds')
        customer_3 = create(:customer, first_name: 'Carl', last_name: 'Cassidy')
        invoice_1 = create(:invoice, customer_id: customer_1.id)
        invoice_2 = create(:invoice, customer_id: customer_1.id)
        invoice_3 = create(:invoice, customer_id: customer_1.id)
        invoice_4 = create(:invoice, customer_id: customer_2.id)
        invoice_5 = create(:invoice, customer_id: customer_2.id)
        invoice_6 = create(:invoice, customer_id: customer_3.id)
        transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: 0)
        transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: 0)
        transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: 0)
        transaction_4 = create(:transaction, invoice_id: invoice_4.id, result: 0)
        transaction_5 = create(:transaction, invoice_id: invoice_5.id, result: 0)
        transaction_6 = create(:transaction, invoice_id: invoice_6.id, result: 0)
        top_customers = Customer.top_customers(2)
        expect(top_customers.first.first_name).to eq('Aaron')
        expect(top_customers.first.last_name).to eq('Adams')
        expect(top_customers.first.count).to eq(3)
        expect(top_customers.second.first_name).to eq('Barry')
        expect(top_customers.second.last_name).to eq('Bonds')
        expect(top_customers.second.count).to eq(2)
      end
    end
    describe '#transaction_count(id)' do 
      it 'can count the number of transactions per customer' do
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)
  
        customer_3 = create(:customer)
        invoice_3 = create(:invoice, customer_id: customer_3.id)
        invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice_3.id)
        transaction_4 = create(:transaction, invoice_id: invoice_3.id)
        transaction_5 = create(:transaction, invoice_id: invoice_3.id)
        transaction_6 = create(:transaction, invoice_id: invoice_3.id)
  
        customer_4 = create(:customer)
        invoice_4 = create(:invoice, customer_id: customer_4.id)
        invoice_item_4 = create(:invoice_item, item_id: item.id, invoice_id: invoice_4.id)
        transaction_7 = create(:transaction, invoice_id: invoice_4.id)
        transaction_8 = create(:transaction, invoice_id: invoice_4.id)
        transaction_9 = create(:transaction, invoice_id: invoice_4.id)
        transaction_10 = create(:transaction, invoice_id: invoice_4.id)
        transaction_21 = create(:transaction, invoice_id: invoice_4.id)
  
        expect(Customer.transaction_count(customer_3.id)).to eq(3)
        expect(Customer.transaction_count(customer_4.id)).to eq(5)
      end
    end
  end
end
