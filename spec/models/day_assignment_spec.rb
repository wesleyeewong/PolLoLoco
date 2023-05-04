# frozen_string_literal: true

# == Schema Information
#
# Table name: day_assignments
#
#  id           :bigint           not null, primary key
#  completed_at :datetime
#  completion   :integer          default("zero"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  day_id       :bigint
#  plan_id      :bigint
#  profile_id   :bigint           not null
#
# Indexes
#
#  index_day_assignments_on_day_id      (day_id)
#  index_day_assignments_on_plan_id     (plan_id)
#  index_day_assignments_on_profile_id  (profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (day_id => days.id)
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (profile_id => profiles.id)
#
require "rails_helper"

RSpec.describe DayAssignment, type: :model do
  # TODO: add specs later when needed
end
