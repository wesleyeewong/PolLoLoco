# frozen_string_literal: true

ActiveRecord::Migration.say_with_time("Seeding movements ...") do
  movement_slugs = YAML.load_file(Rails.root.join("db/seeds/movements.yml"))
  @movements = Movement.create!(movement_slugs.map { |slug| { slug: } })
end

ActiveRecord::Migration.say_with_time("Seeding users and profiles ...") do
  wesley = User.create!(email: "wesley@polloloco.com", name: "Wesley")
  wesley.create_profile!(name: "Wesley")

  ActiveRecord::Migration.say_with_time("Seeding progressions ...") do
    wesley.profile.progressions.create!(
      initial_reps: 5, initial_sets: 5, initial_weight: 0,
      max_reps: 10, max_sets: 5, min_reps: 5, min_sets: 5,
      name: "Some progression", rep_increments: 1, weight_increments: 2.5,
      movement: @movements.first
    )
  end
end
