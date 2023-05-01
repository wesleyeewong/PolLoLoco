# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authenticateable

  rescue_from ActiveRecord::RecordNotFound, with: proc { head :not_found }

  private

  def error(errors)
    render json: errors.to_json, status: :unprocessable_entity
  end
end
