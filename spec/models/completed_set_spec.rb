# frozen_string_literal: true

# == Schema Information
#
# Table name: completed_sets
#
#  id                        :bigint           not null, primary key
#  reps                      :integer          not null
#  weight                    :decimal(8, 3)    not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  progression_assignment_id :bigint           not null
#
# Indexes
#
#  index_completed_sets_on_progression_assignment_id  (progression_assignment_id)
#
# Foreign Keys
#
#  fk_rails_...  (progression_assignment_id => progression_assignments.id)
#
require "rails_helper"

RSpec.describe CompletedSet, type: :model do
end
