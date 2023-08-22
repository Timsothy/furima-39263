FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    info { Faker::Lorem.sentence }
    category { Category.where.not(id: 1).sample }
    sales_status { SalesStatus.where.not(id: 1).sample }
    shipping_fee_status { ShippingFeeStatus.where.not(id: 1).sample }
    prefecture { Prefecture.where.not(id: 1).sample }
    scheduled_delivery { ScheduledDelivery.where.not(id: 1).sample }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
