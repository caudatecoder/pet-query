FactoryBot.define do
  factory :dog do
    trait :valid do
      tracker_type { %w[small medium big].sample }
      owner_id { rand(1000) }
      in_zone { [true, false].sample }
    end
  end
end
