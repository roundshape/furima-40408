FactoryBot.define do
  factory :purchase_delivery do
    token { 'tok_abcdefghijk00000000000000000'}
    post_code { '123-1234' }
    ship_from_id { 2 } # ActiveHashで定義された発送元の地域のID
    city { '東久留米市' }
    address { '八幡町３−６−２２' }
    building { '自宅' }
    phone { '09061972202' }
  end
end
