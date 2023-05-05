# frozen_string_literal: true

# == Schema Information
#
# Table name: progression_assignments
#
#  id                :bigint           not null, primary key
#  reps              :integer          not null
#  rpe               :integer          default(0), not null
#  sets              :integer          not null
#  weight            :decimal(8, 3)    not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  day_assignment_id :bigint           not null
#  progression_id    :bigint
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
require "rails_helper"

RSpec.describe ProgressionAssignment, type: :model do
  describe "#next_progression_hash" do
    context "when progressable" do
      let(:progression_assignment) { create(:progression_assignment, :progressable, progression:) }

      context "rep progression" do
        let(:progression) { create(:progression, max_reps: 2) }

        it "progresses reps only" do
          expect(progression_assignment.next_progression_hash).to eq(
            {
              reps: progression_assignment.reps + progression.rep_increments,
              sets: progression_assignment.sets,
              weight: progression_assignment.weight,
              progression_id: progression.id
            }
          )
        end
      end

      context "set progression" do
        let(:progression) { create(:progression, max_sets: 2) }

        it "progresses sets only" do
          expect(progression_assignment.next_progression_hash).to eq(
            {
              reps: progression_assignment.reps,
              sets: progression_assignment.sets + progression.set_increments,
              weight: progression_assignment.weight,
              progression_id: progression.id
            }
          )
        end
      end

      context "weight progression" do
        let(:progression) { create(:progression) }

        it "progresses weiht only" do
          expect(progression_assignment.next_progression_hash).to eq(
            {
              reps: progression_assignment.reps,
              sets: progression_assignment.sets,
              weight: progression_assignment.weight + progression.weight_increments,
              progression_id: progression.id
            }
          )
        end
      end
    end

    context "when not progressable" do
      context "by insufficient reps" do
        let(:progression_assignment) { create(:progression_assignment, :unprogressable_by_reps) }

        it "returns hash with no progress" do
          expect(progression_assignment.next_progression_hash).to eq(
            {
              reps: progression_assignment.reps,
              sets: progression_assignment.sets,
              weight: progression_assignment.weight,
              progression_id: progression_assignment.progression.id
            }
          )
        end
      end

      context "by insufficient weight" do
        let(:progression_assignment) { create(:progression_assignment, :unprogressable_by_weight) }

        it "returns hash with no progress" do
          expect(progression_assignment.next_progression_hash).to eq(
            {
              reps: progression_assignment.reps,
              sets: progression_assignment.sets,
              weight: progression_assignment.weight,
              progression_id: progression_assignment.progression.id
            }
          )
        end
      end
    end
  end
end
