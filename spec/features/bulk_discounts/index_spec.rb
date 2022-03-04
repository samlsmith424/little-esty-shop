require 'rails_helper'

RSpec.describe 'merchant bullk discounts index page' do
  it 'displays all bulk discounts including their percentage and quantity thresholds' do
    merchant = create(:merchant)
    bulk_disc_1 = create(:bulk_discount)
    bulk_disc_2 = create(:bulk_discount)
    bulk_disc_1 = create(:bulk_discount)
  end
end
