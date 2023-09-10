class OrderForm
  include ActiveModel::Model
  attr_accessor :item, :user, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :order_history

  validates :postal_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :city, presence: true
  validates :addresses, presence: true
  validates :phone_number, presence: true,
                           numericality: { only_integer: true,
                                           greater_than_or_equal_to: 10, less_than_or_equal_to: 11,
                                           message: 'is invalid' }

  def save
    OrderHistory.create(item: item, user: user)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses,
                           building: building, phone_number: phone_number)
  end
end
