class V1::MapSerializer < V1::BaseSerializer
  attributes :id, :created_at

  has_many :tiles, serializer: V1::TileSerializer
  has_many :islands, serializer: V1::IslandSerializer
end
