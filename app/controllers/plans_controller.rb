# frozen_string_literal: true

class PlansController < ApplicationController
  def index
    plan = Current.profile.plan

    if plan
      render json: PlanSerializer.new(plan).call, status: :ok
    else
      head :no_content
    end
  end

  def create
    validator = PlanValidator.new(create_params)

    if validator.call
      plan = Current.profile.create_plan!(name: create_params[:name])
      plan.days.create!(create_params[:days])

      render json: PlanSerializer.new(plan).call, status: :created
    else
      error(validator.errors)
    end
  end

  private

  def create_params
    params.permit(:name, days: [progression_ids: []])
  end
end
