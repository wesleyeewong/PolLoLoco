# frozen_string_literal: true

# == Schema Information
#
# Table name: plans
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :bigint           not null
#
# Indexes
#
#  index_plans_on_profile_id  (profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (profile_id => profiles.id)
#
FactoryBot.define do
  factory :plan do
    association :profile
    name { "Plan Name" }

    trait :with_days do
      after(:create) do |plan|
        2.times { create(:day, plan:) }
      end
    end

    trait :with_days_and_progressions do
      after(:create) do |plan|
        2.times { create(:day, :with_progressions, plan:) }
      end
    end
  end
end
