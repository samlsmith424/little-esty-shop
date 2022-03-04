FactoryBot.define do
  factory :bulk_discount, class: BulkDiscount do
    threshold { 10 }
    discount_percent { 20 }
    merchant
  end
end
