# == Schema Information
#
# Table name: progressions
#
#  id                :bigint           not null, primary key
#  max_reps          :integer          default(1), not null
#  max_sets          :integer          default(1), not null
#  min_reps          :integer          default(1), not null
#  min_sets          :integer          default(1), not null
#  rep_increments    :integer          default(1), not null
#  set_increments    :integer          default(1), not null
#  weight_increments :decimal(8, 3)    default(2.5), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :progression do
    min_sets { 1 }
    max_sets { 1 }
    min_reps { 1 }
    max_reps { 1 }
    weight_increments { "9.99" }
    rep_increments { 1 }
    set_increments { 1 }
  end
end
