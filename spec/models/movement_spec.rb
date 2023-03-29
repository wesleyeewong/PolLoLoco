# frozen_string_literal: true

# == Schema Information
#
# Table name: movements
#
#  id         :bigint           not null, primary key
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_movements_on_slug  (slug) UNIQUE
#
require "rails_helper"

RSpec.describe Movement, type: :model do
  it "has valid factory" do
    expect(build(:movement).valid?).to be(true)
  end
end
