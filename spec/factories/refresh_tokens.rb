# frozen_string_literal: true

# == Schema Information
#
# Table name: refresh_tokens
#
#  id         :bigint           not null, primary key
#  jti        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_refresh_tokens_on_jti      (jti) UNIQUE
#  index_refresh_tokens_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :refresh_token do
    association :user
    jti { RefreshToken.new_jti }
  end
end
