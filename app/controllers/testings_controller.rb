# frozen_string_literal: true

class TestingsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    render json: params.as_json, status: :created
  end
end
