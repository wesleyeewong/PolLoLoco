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
class Plan < ApplicationRecord
  belongs_to :profile

  has_many :days, dependent: :destroy
  has_many :day_assignments, dependent: :nullify

  def next_day(day)
    days_array = days.to_a
    index = days_array.index(day)
    next_day_index = index == days.count - 1 ? 0 : index + 1
    days_array.fetch(next_day_index)
  end
end
