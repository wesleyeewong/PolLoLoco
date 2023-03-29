# == Schema Information
#
# Table name: progressions
#
#  id                :bigint           not null, primary key
#  max_reps          :integer          default(1), not null
#  max_sets          :integer          default(1), not null
#  min_reps          :integer          default(1), not null
#  min_sets          :integer          default(1), not null
#  rep_increments    :integer          default(1), not null
#  set_increments    :integer          default(1), not null
#  weight_increments :decimal(8, 3)    default(2.5), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Progression < ApplicationRecord
  validates :weight_increments, format: { with: /\A\d{1,5}(\.\d{1,3})?\z/ }
end
