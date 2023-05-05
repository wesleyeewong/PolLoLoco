require 'rails_helper'

RSpec.describe "/day_assignment", type: :request do
  let(:profile) { create(:profile) }
  let(:user) { profile.user }

  describe "GET :root/current_day" do
    let(:endpoint) { "/current_day" }

    it_behaves_like(:authenticateable, verb: :get, endpoint: "/current_day")

    context "when profile has no plan" do
      it "returns no content" do
        authorized_get(user, endpoint)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when plan has no days" do
      let!(:plan) { create(:plan, profile:) }

      it "returns no content" do
        authorized_get(user, endpoint)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when plan has days and progressions" do
      let!(:plan) { create(:plan, :with_days_and_progressions, profile:) }

      it "returns day assignment" do
        authorized_get(user, endpoint)

        parsed_body = response.parsed_body

        expect(response).to have_http_status(:ok)
        expect(parsed_body["progression_assignments"].size).to eq(2)
      end
    end
  end
end
