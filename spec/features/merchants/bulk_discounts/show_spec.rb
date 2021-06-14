require 'rails_helper'

RSpec.describe 'Discount Show Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Regina's Ragin' Ragdolls")
    @merchant_2 = Merchant.create!(name: "Mark's Money Makin' Markers")
    @merchant_3 = Merchant.create!(name: "Caleb's California Catapults")

    @bulk_1 = @merchant_1.bulk_discounts.create!(name: 'Discount 1', percent_discounted: 0.15, quantity_threshold: 10)
    @bulk_2 = @merchant_1.bulk_discounts.create!(name: 'Discount 2', percent_discounted: 0.20, quantity_threshold: 15)
    @bulk_3 = @merchant_1.bulk_discounts.create!(name: 'Discount 3', percent_discounted: 0.30, quantity_threshold: 20)
    @bulk_4 = @merchant_1.bulk_discounts.create!(name: 'Discount 4', percent_discounted: 0.35, quantity_threshold: 25)

    @item_1 = @merchant_1.items.create!(name: "Twinkies", description: "Yummy", unit_price: 400)
    @item_2 = @merchant_1.items.create!(name: "Applesauce", description: "Yummy", unit_price: 400)
    @item_3 = @merchant_1.items.create!(name: "Milk", description: "Yummy", unit_price: 400)
    @item_4 = @merchant_1.items.create!(name: "Bread", description: "Yummy", unit_price: 400)
    @item_5 = @merchant_1.items.create!(name: "Ice Cream", description: "Yummy", unit_price: 400)
    @item_6 = @merchant_1.items.create!(name: "Waffles", description: "Yummy", unit_price: 400)
    @item_7 = @merchant_2.items.create!(name: "Desk", description: "Yummy", unit_price: 400)
    @item_8 = @merchant_2.items.create!(name: "Desk Chair", description: "Yummy", unit_price: 400)
    @item_9 = @merchant_2.items.create!(name: "100 pack Pens", description: "Yummy", unit_price: 400)
    @item_10 = @merchant_2.items.create!(name: "Printer Paper", description: "Yummy", unit_price: 400)
    @item_11 = @merchant_2.items.create!(name: "50 pack Markers", description: "Yummy", unit_price: 400)

    @customer_1 = Customer.create!(first_name: "Regina", last_name: "Last Name")
    @customer_2 = Customer.create!(first_name: "Jennifer", last_name: "Last Name")
    @customer_3 = Customer.create!(first_name: "Mark", last_name: "Last Name")
    @customer_4 = Customer.create!(first_name: "Caleb", last_name: "Last Name")
    @customer_5 = Customer.create!(first_name: "Richard", last_name: "Last Name")
    @customer_6 = Customer.create!(first_name: "Zach", last_name: "Last Name")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: "in progress")
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 1)
    @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: 1)
    @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: 1)
    @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: 1)
    @invoice_7 = Invoice.create!(customer_id: @customer_2.id, status: 0)
    @invoice_8 = Invoice.create!(customer_id: @customer_3.id, status: 0)
    @invoice_9 = Invoice.create!(customer_id: @customer_4.id, status: 0)
    @invoice_10 = Invoice.create!(customer_id: @customer_5.id, status: 0)
    @invoice_11 = Invoice.create!(customer_id: @customer_6.id, status: 0)

    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 1500, status: 1)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 15, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 20, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 25, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 30, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_5.id, quantity: 35, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_6.id, quantity: 12, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_6.id, quantity: 17, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_6.id, quantity: 22, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_7.id, quantity: 26, unit_price: 1500, status: 1)
    InvoiceItem.create!(item_id: @item_8.id, invoice_id: @invoice_8.id, quantity: 11, unit_price: 1500, status: 1)
    InvoiceItem.create!(item_id: @item_9.id, invoice_id: @invoice_9.id, quantity: 1, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_10.id, invoice_id: @invoice_10.id, quantity: 2, unit_price: 1500, status: 1)
    InvoiceItem.create!(item_id: @item_11.id, invoice_id: @invoice_11.id, quantity: 5, unit_price: 1500, status: 1)
    InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_11.id, quantity: 7, unit_price: 1500, status: 1)
    InvoiceItem.create!(item_id: @item_9.id, invoice_id: @invoice_8.id, quantity: 0, unit_price: 1500, status: 1)

    Transaction.create!(invoice_id: @invoice_2.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_3.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_4.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_5.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_6.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_7.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_8.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_9.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_10.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_11.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')

    visit "/bulk_discounts/#{@bulk_1.id}"
  end

  it 'shows the attributes of the discount' do
    expect(page).to have_content(@bulk_1.name)
    expect(page).to have_content(@bulk_1.quantity_threshold)
    expect(page).to have_content(@bulk_1.percent_discounted)
  end

  it 'can edit a discount' do
    expect(page).to have_content('Discount 1')
    expect(page).to_not have_content(0.18)
    expect(page).to_not have_content(27)

    click_on 'Edit Discount 1'

    expect(current_path).to eq("/bulk_discounts/#{@bulk_1.id}/edit")

    fill_in :percent_discounted, with: 0.18
    fill_in :quantity_threshold, with: 27

    click_on 'Update Discount'

    expect(current_path).to eq("/bulk_discounts/#{@bulk_1.id}")

    expect(page).to have_content('Discount 1')
    expect(page).to have_content(0.18)
    expect(page).to have_content(27)
  end
end
