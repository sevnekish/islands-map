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

class Tile < ActiveRecord::Base
  enum kind: %i[water land]

  belongs_to :map
  belongs_to :island, optional: true
end
