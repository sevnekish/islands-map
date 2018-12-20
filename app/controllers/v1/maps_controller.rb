class V1::MapsController < V1::BaseController
  def create
    # map = Map.first || RetrieveMap.perform
    #
    response = Net::HTTP.get_response(URI(Settings.map_source_url))
    body = JSON.parse(response.body, symbolize_names: true)

    tiles = body[:attributes][:tiles]

    water_tiles = tiles.select { |tile| tile[:type] == 'water' }
    land_tiles = tiles - water_tiles

    island_tiles = IslandTilesAggregator.new(land_tiles).perform

    map = Map.create

    water_tiles.each do |tile|
      Tile.create(x: tile[:x], y: tile[:y], kind: :water, map: map)
    end

    island_tiles.each do |aggregated_tiles|
      Island.create(map: map) do |island|
        aggregated_tiles.each do |tile|
          island.tiles << Tile.new(x: tile[:x], y: tile[:y], kind: :land, map: map)
        end
      end
    end
    respond_with_serialized_resource_for(map, status: :created)
  end
end