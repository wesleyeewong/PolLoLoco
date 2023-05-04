# frozen_string_literal: true

# == Schema Information
#
# Table name: progression_assignments
#
#  id                :bigint           not null, primary key
#  reps              :integer          not null
#  sets              :integer          not null
#  weight            :decimal(8, 3)    not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  day_assignment_id :bigint           not null
#  progression_id    :bigint           not null
#
# Indexes
#
#  index_progression_assignments_on_day_assignment_id  (day_assignment_id)
#  index_progression_assignments_on_progression_id     (progression_id)
#
# Foreign Keys
#
#  fk_rails_...  (day_assignment_id => day_assignments.id)
#  fk_rails_...  (progression_id => progressions.id)
#
class ProgressionAssignment < ApplicationRecord
  belongs_to :progression
  belongs_to :day_assignment
end
