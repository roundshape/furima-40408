FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name            { '太郎' }
    last_name             { '山田' }
    first_kana            { 'タロウ' }
    last_kana             { 'ヤマダ' }
    birthday              { '1990-01-01' }
  end
end
