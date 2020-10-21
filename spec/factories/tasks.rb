FactoryBot.define do
  factory :task do
    user_id     { Faker::Number.between(from: 1, to: 100) }
    title       { Faker::Name.initials(number: 5) }
    details     { Faker::Name.initials(number: 10) }
    deadline    { Faker::Date.between(from: '2015-01-01', to: '2025-12-31') }
    category_id { Faker::Number.between(from: 1, to: 3) }
    priority_id { Faker::Number.between(from: 1, to: 4) }
    association :user # Taskのインスタンスが生成したと同時に、関連するUserのインスタンスも生成される。Taskに対しては、必ずUserが紐付いている必要があるため、このように記述する必要がある。
  end
end
