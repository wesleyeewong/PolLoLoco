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
class Block < ApplicationRecord
  belongs_to :day

  has_many :movement_plans
end
