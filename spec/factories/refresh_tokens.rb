FactoryBot.define do
  factory :refresh_token do
    user { nil }
    jti { "MyString" }
  end
end
