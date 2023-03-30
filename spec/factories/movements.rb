# frozen_string_literal: true

# == Schema Information
#
# Table name: movements
#
#  id         :bigint           not null, primary key
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_movements_on_slug  (slug) UNIQUE
#
FactoryBot.define do
  factory :movement do
    sequence :slug, %i[barbell_squats barbell_bench_presses barbell_deadlifts squats pushups].cycle
  end
end
