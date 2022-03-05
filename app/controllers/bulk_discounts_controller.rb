class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = HolidayFacade.next_three_holidays
  end

  def show

  end
end
