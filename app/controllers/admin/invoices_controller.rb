class Admin::InvoicesController < ApplicationController
  before_action :load_data, only: [:show, :update]

  def index
    @invoices = Invoice.all
  end

  def show
    # @invoice = Invoice.find(params[:invoice_id])
    # @customer = Customer.find(@invoice.customer_id)
    # @invoice_items = InvoiceItem.find_invoice_items(@invoice.id)
    # @invoice_revenue = Invoice.expected_invoice_revenue(@invoice)[0].invoice_revenue.to_f / 100
    merchants = @invoice.merchants.distinct
    @discounted_revenue = 0

    merchants.each do |merchant|
      if merchant.discounts_greater_than_zero?
        invoice_items = merchant.invoice_items.where(invoice_id: @invoice.id)
        invoice_items.each do |item|
          if item.quantity >= merchant.minimum_discount_quantity
            @discounted_revenue += ((item.quantity * item.unit_price) * (1 - merchant.highest_discount_percentage(item)))
          elsif
            @discounted_revenue += (item.quantity * item.unit_price)
          end
        end
      else
        invoice_items = merchant.invoice_items.where(invoice_id: @invoice.id)
        invoice_items.each do |item|
          @discounted_revenue += (item.quantity * item.unit_price)
        end
      end
    end
  end

  def update
    # @invoice = Invoice.find(params[:invoice_id])
    # @customer = Customer.find(@invoice.customer_id)
    # @invoice_items = InvoiceItem.find_invoice_items(@invoice.id)
    # @invoice_revenue = Invoice.expected_invoice_revenue(@invoice)[0].invoice_revenue.to_f / 100
    @invoice.update(status: params[:status])
    @invoice.save!
    redirect_to "/admin/invoices/#{@invoice.id}"
    # render :show
  end

  private

  def load_data
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    @invoice_items = InvoiceItem.find_invoice_items(@invoice.id)
    @invoice_revenue = Invoice.expected_invoice_revenue(@invoice)[0].invoice_revenue.to_f / 100
  end
end
