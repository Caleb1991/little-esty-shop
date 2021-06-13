class Merchant::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])

    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])

    merchant.bulk_discounts.create!(discount_params)

    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])

    discount = BulkDiscount.find(params[:discount_id])

    BulkDiscount.destroy(discount.id)

    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def edit
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    @discount = BulkDiscount.find(params[:id])

    @discount.update(discount_params)

    redirect_to "/bulk_discounts/#{@discount.id}"
  end

  private
  def discount_params
    params.permit(:name, :quantity_threshold, :percent_discounted)
  end
end
