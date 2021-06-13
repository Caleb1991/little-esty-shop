require 'rails_helper'

RSpec.describe 'New Bulk DIscount Form' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Roald')
  end

  it 'has a form to create a new Bulk Discount' do
    visit "/merchants/#{@merchant_1.id}/bulk_discounts"

    expect(page).to_not have_content('Discount 1')

    click_on 'Create New Discount'

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts/new")

    fill_in :name, with: 'Discount 1'
    fill_in :percent_discounted, with: 0.15
    fill_in :quantity_threshold, with: 15

    click_on 'Create Discount'

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts")
    expect(page).to have_content('Discount 1')
  end
end
