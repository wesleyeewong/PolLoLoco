# frozen_string_literal: true

# == Schema Information
#
# Table name: movement_plans
#
#  id             :bigint           not null, primary key
#  initial_reps   :integer          default(1), not null
#  initial_sets   :integer          default(1), not null
#  initial_weight :decimal(8, 3)    default(1.0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  block_id       :bigint           not null
#  movement_id    :bigint           not null
#  progression_id :bigint           not null
#
# Indexes
#
#  index_movement_plans_on_block_id        (block_id)
#  index_movement_plans_on_movement_id     (movement_id)
#  index_movement_plans_on_progression_id  (progression_id)
#
# Foreign Keys
#
#  fk_rails_...  (block_id => blocks.id)
#  fk_rails_...  (movement_id => movements.id)
#  fk_rails_...  (progression_id => progressions.id)
#
require "rails_helper"

RSpec.describe MovementPlan, type: :model do
  # TODO: Add specs later when needed
end
