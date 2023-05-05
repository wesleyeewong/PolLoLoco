# frozen_string_literal: true

# == Schema Information
#
# Table name: progressions
#
#  id                :bigint           not null, primary key
#  initial_reps      :integer          default(1), not null
#  initial_sets      :integer          default(1), not null
#  initial_weight    :decimal(8, 3)    default(1.0), not null
#  max_reps          :integer          default(1), not null
#  max_sets          :integer          default(1), not null
#  min_reps          :integer          default(1), not null
#  min_sets          :integer          default(1), not null
#  name              :string           not null
#  rep_increments    :integer          default(1), not null
#  set_increments    :integer          default(1), not null
#  weight_increments :decimal(8, 3)    default(2.5), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  movement_id       :bigint           not null
#  profile_id        :bigint           not null
#
# Indexes
#
#  index_progressions_on_movement_id  (movement_id)
#  index_progressions_on_profile_id   (profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (movement_id => movements.id)
#  fk_rails_...  (profile_id => profiles.id)
#
class Progression < ApplicationRecord
  belongs_to :profile
  belongs_to :movement

  has_many :progression_assignments, dependent: :nullify

  has_one :last_progression_assignment, -> { order(created_at: :desc) },
    required: false, class_name: :ProgressionAssignment

  has_and_belongs_to_many :days

  validates :weight_increments, format: { with: /\A\d{1,5}(\.\d{1,3})?\z/ }
end
