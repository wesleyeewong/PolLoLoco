FactoryBot.define do
  factory :progression_assignment do
    progression { nil }
    day_assignment { nil }
    reps { 1 }
    sets { 1 }
    weight { "9.99" }
  end
end
