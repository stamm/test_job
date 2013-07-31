FactoryGirl.define do
  factory :product do
    sequence(:title) { |n| "#{n} #{Faker::Product.product}"}
    price { (rand(10000) + rand).round(2) }
  end
end