class V1::IslandSerializer < V1::BaseSerializer
  attributes :id

  has_many :tiles, serializer: V1::TileSerializer, if: :include_tiles?

  def include_tiles?
    instance_options[:include_tiles].present? && instance_options[:include_tiles]
  end
end
