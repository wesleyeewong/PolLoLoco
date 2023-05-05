require "rails_helper"

RSpec.describe DetermineCurrentDay, type: :service do
  let!(:profile) do
    Current.profile = create(:profile)

    Current.profile
  end
  let!(:plan) { create(:plan, :with_days, profile: profile) }

  describe "#call" do
    subject { described_class.new }

    context "when first day of plan" do
      it "returns valid new day assignment" do
        day_assignment = subject.call

        expect(day_assignment.new_record?).to eq(true)
        expect(day_assignment.valid?).to eq(true)
        expect(day_assignment.profile_id).to eq(profile.id)
        expect(day_assignment.plan_id).to eq(plan.id)
        expect(day_assignment.day_id).to eq(plan.days.first.id)
        expect(day_assignment.zero_completion?).to eq(true)
      end
    end

    context "when last day_assignment relevant" do
      context "by zero completion" do
        let!(:last_day_assignment) { create(:day_assignment, profile:, plan:, day: plan.days.first) }

        it "returns last day assignment" do
          day_assignment = subject.call

          expect(day_assignment.new_record?).to eq(false)
          expect(day_assignment).to eq(last_day_assignment)
        end
      end

      context "by partial completion" do
        let!(:last_day_assignment) do
          create(:day_assignment, :partial_completion, profile:, plan:, day: plan.days.first)
        end

        it "returns last day assignment" do
          day_assignment = subject.call

          expect(day_assignment.new_record?).to eq(false)
          expect(day_assignment).to eq(last_day_assignment)
        end

      end

      context "by same day completion" do
        let!(:last_day_assignment) do
          create(:day_assignment, :full_completion, profile:, plan:, day: plan.days.first)
        end

        it "returns last day assignment" do
          day_assignment = subject.call

          expect(day_assignment.new_record?).to eq(false)
          expect(day_assignment).to eq(last_day_assignment)
        end

      end
    end

    context "when last day_assignment not relevant past day completion" do
      let!(:last_day_assignment) do
        create(
          :day_assignment, :full_completion,
          profile:, plan:, day: plan.days.first, completed_at: Time.current - 5.days
        )
      end

      it "returns valid new day assignment" do
        day_assignment = subject.call

        expect(day_assignment).not_to eq(last_day_assignment)
        expect(day_assignment.new_record?).to eq(true)
        expect(day_assignment.valid?).to eq(true)
        expect(day_assignment.profile_id).to eq(profile.id)
        expect(day_assignment.plan_id).to eq(plan.id)
        expect(day_assignment.day_id).to eq(plan.days.second.id)
        expect(day_assignment.zero_completion?).to eq(true)
      end
    end
  end
end
