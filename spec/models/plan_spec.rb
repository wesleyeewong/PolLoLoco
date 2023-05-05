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
require "rails_helper"

RSpec.describe Plan, type: :model do
  describe "#next_day(day)" do
    let(:first) { create(:day) }
    let(:second) { create(:day) }
    let(:third) { create(:day) }
    let(:plan) { create(:plan, days: [first, second, third]) }

    context "when first day passed in" do
      it "returns next day" do
        expect(plan.next_day(first)).to eq(second)
      end
    end

    context "when middle day passed in" do
      it "returns next day" do
        expect(plan.next_day(second)).to eq(third)
      end
    end

    context "when last day passed in" do
      it "returns first day" do
        expect(plan.next_day(third)).to eq(first)
      end
    end
  end
end
