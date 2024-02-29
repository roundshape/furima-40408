FactoryBot.define do
  factory :item do
    association :user

    category_id { 2 }     # ActiveHashで定義されたカテゴリーのID
    name { Faker::Commerce.product_name }
    detail { Faker::Lorem.paragraph }
    price { rand(300..9_999_999) }
    condition_id { 2 }    # ActiveHashで定義された状態のID
    ship_resp_id { 2 }    # ActiveHashで定義された送料の負担のID
    ship_from_id { 2 }    # ActiveHashで定義された発送元の地域のID
    ship_period_id { 2 }  # ActiveHashで定義された発送までの日数のID

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
