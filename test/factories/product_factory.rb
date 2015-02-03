FactoryGirl.define do

  factory :product, class: Product do
    title {Faker::Commerce.product_name}
    price {Faker::Commerce.price}
    desc {Faker::Lorem.sentence}
    image_link {Faker::Internet.url }

  end
end
