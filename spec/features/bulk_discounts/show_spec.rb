require 'rails_helper'

RSpec.describe 'merchant bulk discount show page' do
    before(:each) do
      @merchant = create(:merchant)
      @bulk_disc_1 = create(:bulk_discount, merchant_id: @merchant.id, threshold: 150000, discount_percent: 66 )
      @bulk_disc_2 = create(:bulk_discount, merchant_id: @merchant.id, threshold: 15, discount_percent: 25 )
      @bulk_disc_3 = create(:bulk_discount, merchant_id: @merchant.id, threshold: 5 , discount_percent: 10 )
    end

  it 'displays the bulk discounts quantity threshold and percent discount' do
    # visit merchant_bulk_discounts_path(@merchant, @bulk_disc_3)
    visit "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_disc_3.id}"

    expect(page).to have_content("#{@merchant.name}'s Discount #{@bulk_disc_3.id}")
    expect(page).to have_content("Discount Information")
    expect(page).to have_content(@bulk_disc_3.threshold)
    expect(page).to have_content(@bulk_disc_3.discount_percent)
    expect(page).to_not have_content(@bulk_disc_2.threshold)
    expect(page).to_not have_content(@bulk_disc_2.discount_percent)
  end 
end
