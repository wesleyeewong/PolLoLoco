# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { generate(:email) }
    name { "George" }
  end
end
