FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {"abc@email"} # 一意性チェックで引っかかることがあるためFaker使っていない
    password              {Faker::Internet.password(min_length: 6)} # Fakerで英数字混合の指定できないため、たまに引っかかる
    password_confirmation {password}
  end
end
