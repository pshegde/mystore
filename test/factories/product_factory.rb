FactoryGirl.define do

  factory :product, class: Product do
    id {Faker::Number.digit}
    title {Faker::Commerce.product_name}
    price {Faker::Commerce.price}
    desc {Faker::Lorem.sentence}
    image_link {Faker::Internet.url + ".jpg" }

  end
end
