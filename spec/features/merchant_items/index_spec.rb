require 'rails_helper'

RSpec.describe 'Merchant Items Index' do

  #   Merchant Items Index Page
  #
  # As a merchant,
  # When I visit my merchant items index page ("merchants/merchant_id/items")
  # I see a list of the names of all of my items
  # And I do not see items for any other merchant
  it 'Can can visist a merchant index page' do
    merchant = Merchant.create!(name: 'Schroeder-Jerde')
    merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510)
    visit "/merchants/#{merchant.id}/items"
    expect(current_path).to eq("/merchants/#{merchant.id}/items")
    expect(page).to have_content('Schroeder-Jerde')
    expect(page).to have_content('Item Qui Esse')
  end

  #   Merchant Item Disable/Enable
  #
  # As a merchant
  # When I visit my items index page
  # Next to each item name I see a button to disable or enable that item.
  # When I click this button
  # Then I am redirected back to the items index
  # And I see that the items status has changed
  it 'can update status of an item' do
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item_1 = @merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510, status: "enable")
    visit "/merchants/#{@merchant.id}/items"
    # binding.pry
    find_button("Disable #{@item_1.name}").click

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    expect(page).to have_button("Enable #{@item_1.name}")

    @item_1 = Item.find(@item_1.id)

    expect(@item_1.status).to eq("disable")
  end

  #   Merchant Items Grouped by Status
  #
  # As a merchant,
  # When I visit my merchant items index page
  # Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
  # And I see that each Item is listed in the appropriate section
  it 'Items are separated into enable and disable' do
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item_1 = @merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510, status: "enable")
    visit "/merchants/#{@merchant.id}/items"

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    expect(page).to have_content("Disabled Items")
    expect(page).to have_content("Enabled Items")
  end

  #   Merchant Item Create
  #
  # As a merchant
  # When I visit my items index page
  # I see a link to create a new item.
  # When I click on the link,
  # I am taken to a form that allows me to add item information.
  # When I fill out the form I click ‘Submit’
  # Then I am taken back to the items index page
  # And I see the item I just created displayed in the list of items.
  # And I see my item was created with a default status of disabled.
  it 'Can add a new item for merchant' do
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item_1 = @merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510, status: "enable")
    visit "/merchants/#{@merchant.id}/items"

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")

    expect(page).to have_button("Add a New Item")
    click_button("Add a New Item")

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")
    fill_in( 'Name', with: "New Item Name")
    fill_in( 'Description', with: "Made from 100% cotton.")
    fill_in( 'Unit price', with: 75608)
    click_on("Submit")

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    expect(page).to have_content("New Item Name")
    # save_and_open_page
  end
  #   Merchant Items Index: 5 most popular items
  #
  # As a merchant
  # When I visit my items index page
  # Then I see the names of the top 5 most popular items ranked by total revenue generated
  # And I see that each item name links to my merchant item show page for that item
  # And I see the total revenue generated next to each item name
  #
  # Notes on Revenue Calculation:
  # - Only invoices with at least one successful transaction should count towards revenue
  # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
  # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
  it 'shows top 5 times for merchant' do
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item_1 = @merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510, status: "enable")
    visit "/merchants/#{@merchant.id}/items"

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")

  end

end
