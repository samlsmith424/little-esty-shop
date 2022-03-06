require 'rails_helper'

RSpec.describe 'create new merchant discount' do
  before(:each) do
    @merchant = create(:merchant)
    @bulk_disc_1 = create(:bulk_discount, merchant_id: @merchant.id)
    @bulk_disc_2 = create(:bulk_discount, merchant_id: @merchant.id, threshold: 15, discount_percent: 25 )
    @bulk_disc_3 = create(:bulk_discount, merchant_id: @merchant.id, threshold: 5 , discount_percent: 10 )
    visit new_merchant_bulk_discount_path(@merchant.id)
  end

  it 'can create a new discount' do
    expect(page).to have_content("Create Discount")
    expect(page).to have_field("Discount percent")
    expect(page).to have_field("Threshold")

    fill_in("Discount percent", with: 20)
    fill_in("Threshold", with: 11)
    click_on("Save")

    expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts")
    expect(page).to have_content("Threshold: 11")
    expect(page).to have_content("Percent Discount: 20")
  end

  it 'does not create a discount if all fields are not filled in' do
    expect(page).to have_content("Create Discount")
    expect(page).to have_field("Discount percent")
    expect(page).to have_field("Threshold")

    fill_in("Discount percent", with: 22)
    click_on("Save")

    expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/new")
    expect(page).to have_content("All categories must be filled out.")
  end
end
