require 'rails_helper'

RSpec.describe 'merchant bulk discounts index page' do
  before(:each) do
    @merchant = create(:merchant)
    @bulk_disc_1 = create(:bulk_discount, merchant_id: @merchant.id)
    @bulk_disc_2 = create(:bulk_discount, merchant_id: @merchant.id, threshold: 15, discount_percent: 25 )
    @bulk_disc_3 = create(:bulk_discount, merchant_id: @merchant.id, threshold: 5 , discount_percent: 10 )
    # @data = { name: "Good Friday" }
    # @holiday = Holiday.new(@data)
    visit merchant_bulk_discounts_path(@merchant.id)
  end

  around(:each) do |test|
    VCR.use_cassette('holiday api', &test)
  end

  it 'displays all bulk discounts including their percentage and quantity thresholds' do
    expect(page).to have_content("#{@merchant.name}'s Discounts")

    within("#discount-#{@bulk_disc_1.id}") do
      expect(page).to have_content(@bulk_disc_1.threshold)
      expect(page).to have_content(@bulk_disc_1.discount_percent)
    end

    within("#discount-#{@bulk_disc_2.id}") do
      expect(page).to have_content(@bulk_disc_2.threshold)
      expect(page).to have_content(@bulk_disc_2.discount_percent)
    end

    within("#discount-#{@bulk_disc_3.id}") do
      expect(page).to have_content(@bulk_disc_3.threshold)
      expect(page).to have_content(@bulk_disc_3.discount_percent)
    end
  end

  it 'each bulk discount has a link to its show page' do
    within("#discount-#{@bulk_disc_1.id}") do
      expect(page).to have_link("More Info for Discount #{@bulk_disc_1.id}")
      click_link("More Info for Discount #{@bulk_disc_1.id}")
      expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_disc_1.id}")
    end
  end

  it 'can list the name and date of the next 3 upcoming US holidays' do

    expect(page).to have_content("Good Friday")
    expect(page).to have_content("Memorial Day")
    expect(page).to have_content("Juneteenth")
  end
end
