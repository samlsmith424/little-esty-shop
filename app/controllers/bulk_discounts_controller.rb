class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = HolidayFacade.next_three_holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:id])
    bulk_discount = merchant.bulk_discounts.new(bulk_discount_params)
    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(merchant.id), notice: "Save successful."
    else
      redirect_to new_merchant_bulk_discount_path(merchant.id), notice: "All categories must be filled out."
    end
  end

  def destroy
    bulk_discount = BulkDiscount.find(params[:discount_id])
    bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(params[:id])
  end

  private
  def bulk_discount_params
    params.permit(:discount_percent, :threshold, :merchant_id)
  end
end
