# == Schema Information
#
# Table name: islands
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  map_id     :bigint(8)
#
# Indexes
#
#  index_islands_on_map_id  (map_id)
#
# Foreign Keys
#
#  fk_rails_...  (map_id => maps.id)
#

class Island < ActiveRecord::Base
  belongs_to :map
  has_many :tiles
end
