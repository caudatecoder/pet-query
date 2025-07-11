FactoryBot.define do
  factory :cat do
    trait :valid do
      tracker_type { %w[small big].sample }
      owner_id { rand(1000) }
      in_zone { [true, false].sample }
      lost_tracker { [false].sample }
    end
  end
end
