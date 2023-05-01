# frozen_string_literal: true

class ProgressionsController < ApplicationController
  def index
    progressions = Current.profile.progressions.includes(:movement)

    render json: progressions.as_json(
      except: %i[movement_id profile_id created_at updated_at],
      include: { movement: { only: %i[id slug] } }
    ), status: :ok
  end

  def create; end
end
