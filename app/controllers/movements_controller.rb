# frozen_string_literal: true

class MovementsController < ApplicationController
  def index
    render json: Movement.all.as_json(only: %i[slug id]), stats: :ok
  end
end
