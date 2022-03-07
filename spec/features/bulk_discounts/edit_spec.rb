require 'rails_helper'

RSpec.describe 'merchant bulk discount edit page' do
    before(:each) do
      @merchant = create(:merchant)
      @bulk_disc_1 = create(:bulk_discount, merchant_id: @merchant.id, threshold: 150000, discount_percent: 66 )
      @bulk_disc_2 = create(:bulk_discount, merchant_id: @merchant.id, threshold: 15, discount_percent: 25 )
      @bulk_disc_3 = create(:bulk_discount, merchant_id: @merchant.id, threshold: 5 , discount_percent: 10 )
    end

  it 'has a form to edit a discount' do
    visit "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_disc_3.id}/edit"

    expect(page).to have_content("Edit Discount #{@bulk_disc_3.id}")
  end

  it 'has the discounts current attributes prepopulated in the form' do
    visit "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_disc_3.id}/edit"

    within("#edit_discount") do
      expect(page).to have_field("Discount percent", with: @bulk_disc_3.discount_percent)
      expect(page).to have_field("Threshold", with: @bulk_disc_3.threshold)
    end
  end

  it 'redirects back to the discount show page with new changes' do
    visit "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_disc_3.id}/edit"

    within("#edit_discount") do
      fill_in("Discount percent", with: 66)
      fill_in("Threshold", with: 44)
      click_on("Submit")
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant.id, @bulk_disc_3.id))
    # expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_disc_3.id}")
    # expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_disc_3.id}")
    expect(page).to have_content(66)
  end
end
