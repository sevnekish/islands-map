class Map::Retrieve
  attr_accessor :source, :tiles, :water_tiles, :island_tiles

  def initialize(source)
    @source = source
  end

  def perform
    get_tiles
    aggregate_tiles
    create_map
  end

  private

  def get_tiles
    response = Net::HTTP.get_response(URI(source))

    body = JSON.parse(response.body, symbolize_names: true)

    @tiles = body[:attributes][:tiles]
  end

  def aggregate_tiles
    @water_tiles = tiles.select { |tile| tile[:type] == 'water' }
    land_tiles = tiles - water_tiles

    @island_tiles = IslandTilesAggregator.new(land_tiles).perform
  end

  def create_map
    Map.create! do |map|
      water_tiles.each do |tile|
        map.tiles << Tile.new(x: tile[:x], y: tile[:y], kind: :water)
      end

      island_tiles.each do |aggregated_tiles|
        map.islands << Island.new(map: map) do |island|
          aggregated_tiles.each do |tile|
            map.tiles << Tile.new(x: tile[:x], y: tile[:y], kind: :land, island: island)
          end
        end
      end
    end
  end
end
