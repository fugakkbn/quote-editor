class Quote < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  after_create_commit -> { broadcast_prepend_later_to 'quotes' }
  after_update_commit -> { broadcast_replace_later_to 'quotes' }
  # broadcast_remove_later_to はない
  # Jobが実行される前に当該Quoteが削除されてしまうと、
  # JobでQuoteを見つけることができなくなってしまうため
  after_destroy_commit -> { broadcast_remove_to 'quotes' }
end
