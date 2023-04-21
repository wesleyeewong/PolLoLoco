# frozen_string_literal: true

# == Schema Information
#
# Table name: progressions
#
#  id                :bigint           not null, primary key
#  initial_reps      :integer          default(1), not null
#  initial_sets      :integer          default(1), not null
#  initial_weight    :decimal(8, 3)    default(1.0), not null
#  max_reps          :integer          default(1), not null
#  max_sets          :integer          default(1), not null
#  min_reps          :integer          default(1), not null
#  min_sets          :integer          default(1), not null
#  rep_increments    :integer          default(1), not null
#  set_increments    :integer          default(1), not null
#  weight_increments :decimal(8, 3)    default(2.5), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  movement_id       :bigint           not null
#  profile_id        :bigint           not null
#
# Indexes
#
#  index_progressions_on_movement_id  (movement_id)
#  index_progressions_on_profile_id   (profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (movement_id => movements.id)
#  fk_rails_...  (profile_id => profiles.id)
#
require "rails_helper"

RSpec.describe Progression, type: :model do
  describe "validation" do
    context "when weight_increments has more than 8 precisions" do
      it "is invalid" do
        expect(build(:progression, weight_increments: "999999.999").valid?).to be(false)
      end
    end
  end
end
