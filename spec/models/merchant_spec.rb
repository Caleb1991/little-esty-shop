require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant_1 = Merchant.create!(name: "Regina's Ragin' Ragdolls")
    @merchant_2 = Merchant.create!(name: "Mark's Money Makin' Markers")
    @merchant_3 = Merchant.create!(name: "Caleb's California Catapults")

    @item_1 = @merchant_1.items.create!(name: "Twinkies", description: "Yummy", unit_price: 400)
    @item_2 = @merchant_1.items.create!(name: "Applesauce", description: "Yummy", unit_price: 400)
    @item_3 = @merchant_1.items.create!(name: "Milk", description: "Yummy", unit_price: 400)
    @item_4 = @merchant_1.items.create!(name: "Bread", description: "Yummy", unit_price: 400)
    @item_5 = @merchant_1.items.create!(name: "Ice Cream", description: "Yummy", unit_price: 400)
    @item_6 = @merchant_1.items.create!(name: "Waffles", description: "Yummy", unit_price: 400)

    @customer_1 = Customer.create!(first_name: "Regina", last_name: "Last Name")
    @customer_2 = Customer.create!(first_name: "Jennifer", last_name: "Last Name")
    @customer_3 = Customer.create!(first_name: "Mark", last_name: "Last Name")
    @customer_4 = Customer.create!(first_name: "Caleb", last_name: "Last Name")
    @customer_5 = Customer.create!(first_name: "Richard", last_name: "Last Name")
    @customer_6 = Customer.create!(first_name: "Zach", last_name: "Last Name")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 0)
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 1)
    @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: 1)
    @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: 1)
    @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: 1)


    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 4, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 3, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 2, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 2, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: 1500, status: 0)

    Transaction.create!(invoice_id: @invoice_2.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_3.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_4.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_5.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_6.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
  end

  describe "validations" do
    it {should validate_presence_of :name}
    # it {should validate_presence_of :status}
    #WIP - unsure of where to input
  end
  describe "relationships" do
    it {should have_many  :items}
  end

  describe 'methods' do
    it 'can find top 5 customers' do
      expect(@merchant_1.top_5_customers[0].customer_id).to eq(@customer_6.id)
      expect(@merchant_1.top_5_customers[1].customer_id).to eq(@customer_5.id)
      expect(@merchant_1.top_5_customers[2].customer_id).to eq(@customer_4.id)
      expect(@merchant_1.top_5_customers[3].customer_id).to eq(@customer_2.id)
      expect(@merchant_1.top_5_customers[4].customer_id).to eq(@customer_3.id)
    end

    it 'can list top days' do
      expect(@merchant_1.top_days.length).to eq(9)
    end

    it 'can list top 5 items' do
      expect(@merchant_1.top_5).to eq([@item_2, @item_3, @item_4, @item_6, @item_1])
    end
  end
end
