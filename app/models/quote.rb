class Quote < ApplicationRecord
  has_many :line_item_dates, dependent: :destroy
  has_many :line_items, through: :line_item_dates
  belongs_to :company

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  # Company ごとに broadcast 先を変える必要がある
  # 変えないと、違う Company のユーザにも broadcast されてしまい、
  # 一時的に Quote が見えてしまう。
  broadcasts_to -> (quote) { [quote.company, 'quotes'] }, inserts_by: :prepend

  def total_price
    line_items.sum(&:total_price)
  end
end
