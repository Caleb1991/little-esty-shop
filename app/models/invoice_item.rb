class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates_presence_of :status
  belongs_to :invoice
  belongs_to :item

  has_many :transactions, through: :invoice
  has_many :bulk_discounts, through: :merchants

  enum status: ['pending', 'packaged', 'shipped']

  def self.find_invoice_items(params)
    joins(:item)
      .select('items.*, invoice_items.invoice_id, invoice_items.status, invoice_items.quantity')
      .where('invoice_id = ?', params)
  end

  def convert_to_dollar
    if unit_price.nil?
      0
    else
      unit_price.to_f / 100
    end
  end

  def discount_applied?(merchant)
    #
    self.quantity >= merchant.bulk_discounts.minimum(:quantity_threshold)
  end

  def bulk_discount(merchant)
    #
    merchant.bulk_discounts.where('quantity_threshold <= ?', self.quantity).order(percent_discounted: :desc).first
  end
end
