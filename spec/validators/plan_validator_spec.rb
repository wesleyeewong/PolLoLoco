require "rails_helper"

RSpec.describe PlanValidator, type: :validator do
  subject { described_class.new(params) }
  let(:params) {
    ActionController::Parameters.new(
      {
        name: name,
        days: days
      }
    )
  }
  let(:name) { "Genesis" }
  let(:days) { [{progression_ids: [1]}] }

  context "when valid" do
    it "returns true" do
      expect(subject.call).to eq(true)
    end
  end

  context "when invalid" do
    context "missing name" do
      let(:name) { "" }

      it "returns false" do
        expect(subject.call).to eq(false)
      end

      it "has errors" do
        subject.call

        expect(subject.errors.count).to eq(1)
        expect(subject.errors.first.attribute). to eq(:name)
      end
    end

    context "missing days" do
      let(:days) { [] }

      it "returns false" do
        expect(subject.call).to eq(false)
      end

      it "has errors" do
        subject.call

        expect(subject.errors.count).to eq(1)
        expect(subject.errors.first.attribute).to eq(:days)
      end
    end
  end
end
