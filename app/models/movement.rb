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
class Movement < ApplicationRecord
end
