# frozen_string_literal: true

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
#  profile_id        :bigint           not null
#
# Indexes
#
#  index_progressions_on_profile_id  (profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (profile_id => profiles.id)
#
require "rails_helper"

RSpec.describe Progression, type: :model do
  it "has valid factory" do
    expect(build(:progression).valid?).to be(true)
  end

  describe "validation" do
    context "when weight_increments has more than 8 precisions" do
      it "is invalid" do
        expect(build(:progression, weight_increments: "999999.999").valid?).to be(false)
      end
    end
  end
end
