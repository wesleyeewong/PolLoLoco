# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProgressionValidator, type: :validator do
  subject { described_class.new(params) }
  let(:params) { ActionController::Parameters.new(params_hash) }
  let(:params_hash) do
    {
      name:, movement_id:,
      initial_reps:, initial_sets:, initial_weight:,
      max_reps:, max_sets:, min_reps:, min_sets:,
      rep_increments:, set_increments:, weight_increments:
    }
  end
  let(:name) { "Some progression" }
  let(:movement_id) { create(:movement).id }
  let(:initial_reps) { 5 }
  let(:initial_sets) { 5 }
  let(:initial_weight) { 20 }
  let(:max_reps) { 10 }
  let(:max_sets) { 5 }
  let(:min_reps) { 5 }
  let(:min_sets) { 5 }
  let(:rep_increments) { 1 }
  let(:set_increments) { 1 }
  let(:weight_increments) { 5 }

  context "when valid" do
    it "returns true" do
      expect(subject.call).to eq(true)
    end
  end

  context "when invalid" do
    ProgressionValidator::ATTRIBUTES.each do |key|
      next if key == :movement_slug

      context "missing #{key}" do
        let(:params) { ActionController::Parameters.new(params_hash.except(key)) }

        it "returns false" do
          expect(subject.call).to eq(false)
        end
      end
    end

    context "missing movement" do
      let(:movement_id) { -404 }

      it "raises ActiveRecord::RecordNotFound" do
        expect(subject.call).to eq(false)
      end
    end
  end
end
