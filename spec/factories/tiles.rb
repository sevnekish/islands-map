# == Schema Information
#
# Table name: tiles
#
#  id         :bigint(8)        not null, primary key
#  kind       :integer          not null
#  x          :integer          not null
#  y          :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  island_id  :bigint(8)
#  map_id     :bigint(8)
#
# Indexes
#
#  index_tiles_on_island_id  (island_id)
#  index_tiles_on_map_id     (map_id)
#
# Foreign Keys
#
#  fk_rails_...  (map_id => maps.id)
#

FactoryBot.define do
  factory :tile do
    map
    kind { :water }
    x { rand(1..5) }
    y { rand(1..5) }

    trait :land do
      kind { :land }
      island
    end
  end
end
