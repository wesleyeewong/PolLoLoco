# frozen_string_literal: true

class BaseValidator
  include ActiveModel::Validations

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    valid?
  end

  def read_attribute_for_validation(key)
    params[key]
  end
end
