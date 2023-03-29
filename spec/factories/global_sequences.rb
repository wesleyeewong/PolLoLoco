# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |x|
    "email_#{x}@domain.com"
  end
end
