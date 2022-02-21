class InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
    @merchant = Merchant.find(params[:id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:invoice_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:invoice_id])
    @invoice_item = InvoiceItem.find(params[:invoice_item_id])
    @invoice_item.update(invoice_item_params)
    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end

  private
  def invoice_item_params
    params.permit(:status)
  end
end
