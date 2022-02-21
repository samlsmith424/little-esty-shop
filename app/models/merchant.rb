class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  validates :name, presence: true
                        
    def favorite_customers(count)
      Merchant.joins(invoice_items: [invoice: [customer: :transactions]])
      .where(merchants: {id: id}, transactions: {result: 0})
      .select("customers.*").group("customers.id").order(count: :desc)
      .limit(count)
    end

    def items_ready_to_ship
      Merchant.joins(invoice_items: [invoice: :transactions])
      .where(merchants: {id: id}, invoice_items: {status: [0,1]}, invoices: {status: [0,1]}, transactions: {result: 0})
      .select("items.name, invoices.id, invoices.created_at").order("invoices.created_at ASC")                            
    end
  end
