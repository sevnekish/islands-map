# == Schema Information
#
# Table name: maps
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Map < ActiveRecord::Base
  has_many :tiles,   dependent: :destroy
  has_many :islands, dependent: :destroy
end
