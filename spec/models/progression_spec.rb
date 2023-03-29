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
require 'rails_helper'

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

    context "when weight_increments has more than 3 scales" do
      it "is invalid" do
        expect(build(:progression, weight_increments: "99.9999").valid?).to be(false)
      end
    end
  end
end
