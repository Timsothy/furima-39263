class ShippingAddress < ApplicationRecord
  belongs_to :order_history
end
