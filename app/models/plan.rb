# frozen_string_literal: true

# == Schema Information
#
# Table name: plans
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :bigint           not null
#
# Indexes
#
#  index_plans_on_profile_id  (profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (profile_id => profiles.id)
#
class Plan < ApplicationRecord
  belongs_to :profile

  has_many :days, dependent: :destroy
  has_many :day_assignemtns, dependent: :nullify
end
