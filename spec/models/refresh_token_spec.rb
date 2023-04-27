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
require "rails_helper"

RSpec.describe RefreshToken, type: :model do
  it "has valid factory" do
    expect(build(:refresh_token).valid?).to be(true)
  end
end