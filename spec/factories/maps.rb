# == Schema Information
#
# Table name: maps
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :map do
    trait :simple_map do
      after(:create) do |map|
        # 0 1 0
        # 0 0 0
        # 1 1 0

        # create water tiles
        create :tile, x: 1, y:1, kind: :water, map: map
        create :tile, x: 3, y:1, kind: :water, map: map
        create :tile, x: 1, y:2, kind: :water, map: map
        create :tile, x: 2, y:2, kind: :water, map: map
        create :tile, x: 3, y:2, kind: :water, map: map
        create :tile, x: 3, y:3, kind: :water, map: map

        # create islands
        create :island, map: map, tiles: [
          build(:tile, x: 2, y: 1, kind: :land, map: map)
        ]

        create :island, map: map, tiles: [
          build(:tile, x: 1, y: 3, kind: :land, map: map),
          build(:tile, x: 2, y: 3, kind: :land, map: map),
        ]
      end
    end
  end
end
