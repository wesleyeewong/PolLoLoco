# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/plans", type: :request do
  let(:profile) { create(:profile) }
  let(:user) { profile.user }
  let(:progression) { create(:progression, profile:) }
  let(:endpoint) { "/plans" }

  describe "POST /" do
    let(:params) { { name: "Genesis", days: } }
    let(:days) { [{ progression_ids: [progression.id] }] }

    it_behaves_like(:authenticateable, verb: :post, endpoint: "/plans")

    context "when invalid params" do
      context "missing plan name" do
        let(:params) { { name: "", days: } }

        it "returns unprocessable entity with error message" do
          authorized_post(user, endpoint, params:)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body).to match("name" => ["can't be blank"])
        end
      end

      context "missing days" do
        let(:days) { [] }

        it "returns unprocessable entity, with error message" do
          authorized_post(user, endpoint, params:)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body).to match("days" => ["can't be blank"])
        end
      end

      context "non existing progression" do
        let(:days) { [{ progression_ids: [-404] }] }

        it "returns not found" do
          authorized_post(user, endpoint, params:)

          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context "when valid params" do
      it "returns created" do
        authorized_post(user, endpoint, params:)

        expect(response).to have_http_status(:created)
      end

      it "creates plan for user" do
        expect(profile.plan).to eq(nil)
        expect do
          authorized_post(user, endpoint, params:)
        end.to change { Plan.count }.by 1

        profile.reload

        expect(profile.plan).not_to eq(nil)
        expect(profile.plan.name).to eq("Genesis")
      end
    end
  end
end
