# frozen_string_literal: true

class BaseValidator
  include ActiveModel::Validations

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    return false unless valid?

    true
  end

  def read_attribute_for_validation(key)
    params[key]
  end
end
