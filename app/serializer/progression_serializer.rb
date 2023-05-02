# frozen_string_literal: true

class ProgressionSerializer < BaseSerializer
  def call
    progression.as_json(
      except: %i[movement_id profile_id created_at updated_at],
      include: { movement: { only: %i[id slug] } }
    )
  end
end
