# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/progressions", type: :request do
  let(:profile) { create(:profile) }
  let(:user) { profile.user }
  let(:endpoint) { "/progressions" }

  describe "GET /" do
    it_behaves_like(:authenticateable, verb: :get, endpoint: "/progressions")

    it "returns ok" do
      authorized_get(user, endpoint)

      expect(response).to have_http_status(:ok)
    end

    context "when profile has no progressions" do
      it "returns empty array" do
        authorized_get(user, endpoint)

        expect(response.parsed_body).to eq([])
      end
    end

    context "when profile has progressions" do
      let!(:progressions) do
        create(:progression)

        [
          create(:progression, profile:),
          create(:progression, profile:)
        ]
      end

      it "returns progressions associated to user" do
        authorized_get(user, endpoint)

        expect(response.parsed_body.count).to eq(2)
        expect(response.parsed_body.pluck("id")).to match_array(progressions.pluck(:id))
      end
    end
  end

  describe "POST /" do
    it_behaves_like(:authenticateable, verb: :post, endpoint: "/progressions")

    let(:params) do
      {
        name: "Some progression", movement_id:,
        initial_reps: 5, initial_sets: 5, initial_weight: 20,
        max_reps: 10, max_sets: 5, min_reps: 5, min_sets: 5,
        rep_increments: 1, set_increments: 1, weight_increments: 5
      }
    end
    let(:movement_id) { create(:movement).id }

    it "returns created" do
      authorized_post(user, endpoint, params:)

      expect(response).to have_http_status(:created)
    end

    context "when invalid params" do
      context "missing attributes" do
        let(:params) do
          {
            name: "Some progression", movement_id:,
            initial_reps: 5, initial_sets: 5, initial_weight: 20,
            max_reps: 10, max_sets: 5, min_reps: 5, min_sets: 5
          }
        end

        it "returns unprocessable entity with error message" do
          authorized_post(user, endpoint, params:)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body).to match(
            "rep_increments" => ["can't be blank"],
            "set_increments" => ["can't be blank"],
            "weight_increments" => ["can't be blank"]
          )
        end
      end

      context "non existing movement" do
        let(:movement_id) { -404 }
        it "returns not found" do
          authorized_post(user, endpoint, params:)

          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
