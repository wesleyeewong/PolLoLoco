# frozen_string_literal: true

# == Schema Information
#
# Table name: blocks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  day_id     :bigint           not null
#
# Indexes
#
#  index_blocks_on_day_id  (day_id)
#
# Foreign Keys
#
#  fk_rails_...  (day_id => days.id)
#
require "rails_helper"

RSpec.describe Block, type: :model do
  # TODO: Add specs later when needed
end