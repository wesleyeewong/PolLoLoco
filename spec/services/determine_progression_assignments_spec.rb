# frozen_string_literal: true

require "rails_helper"

RSpec.describe DetermineProgressionAssignments, type: :service do
  let!(:profile) do
    Current.profile = create(:profile)

    Current.profile
  end
  let!(:plan) { create(:plan, :with_days, profile:) }
  let!(:progression1) do
    create(
      :progression, :with_rep_progressions, profile:,
      initial_reps: 1, initial_sets: 1, initial_weight: 0, days: [plan.days.first]
    )
  end
  let!(:progression2) do
    create(:progression, profile:, initial_reps: 2, initial_sets: 2, initial_weight: 1, days: [plan.days.first])
  end
  let!(:day_assignment) { build(:day_assignment, day: plan.days.first, profile:, plan:) }

  describe "#call" do
    subject { described_class.new(day_assignment) }

    context "when progression does not have previous assignments" do
      it "uses the progression initial values for assignment" do
        progression_assignments = subject.call

        expect(progression_assignments.count).to eq(2)
        expect(progression_assignments.map(&:new_record?)).to eq([true, true])
        expect(progression_assignments.pluck(:progression_id)).to match([progression1.id, progression2.id])
        expect(progression_assignments.pluck(:reps)).to match([1, 2])
        expect(progression_assignments.pluck(:sets)).to match([1, 2])
        expect(progression_assignments.pluck(:weight)).to match([0, 1])
      end
    end

    context "when progression has previous assignment" do
      context "and progressesable" do
        let!(:last_progression_assignment) do
          create(:progression_assignment, :progressable, progression: progression1)
        end

        it "assigns progressed values" do
          progression_assignments = subject.call

          expect(progression_assignments.count).to eq(2)
          expect(progression_assignments.map(&:new_record?)).to eq([true, true])
          expect(progression_assignments.pluck(:progression_id)).to match([progression1.id, progression2.id])
          expect(progression_assignments.pluck(:reps)).to match([2, 2])
          expect(progression_assignments.pluck(:sets)).to match([1, 2])
          expect(progression_assignments.pluck(:weight)).to match([last_progression_assignment.weight, 1])
        end
      end

      context "and does not progress" do
        let!(:last_progression_assignment) do
          create(:progression_assignment, :unprogressable_by_reps, progression: progression1)
        end

        it "assigns previous values" do
          progression_assignments = subject.call

          expect(progression_assignments.count).to eq(2)
          expect(progression_assignments.map(&:new_record?)).to eq([true, true])
          expect(progression_assignments.pluck(:progression_id)).to match([progression1.id, progression2.id])
          expect(progression_assignments.pluck(:reps)).to match([last_progression_assignment.reps, 2])
          expect(progression_assignments.pluck(:sets)).to match([last_progression_assignment.sets, 2])
          expect(progression_assignments.pluck(:weight)).to match([last_progression_assignment.weight, 1])
        end
      end
    end
  end
end
