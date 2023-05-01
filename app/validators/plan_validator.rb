# frozen_string_literal: true

class PlanValidator < BaseValidator
  validates_presence_of :name
  validates_presence_of :days
end
