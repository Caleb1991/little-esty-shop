class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.float :percent_discounted
      t.integer :quantity_threshold
      t.string :name
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
