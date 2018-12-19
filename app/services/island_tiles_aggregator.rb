class IslandTilesAggregator
  attr_accessor :land_tiles, :x_length, :y_length

  def initialize(land_tiles)
    @land_tiles = land_tiles
  end

  def perform
    return [] if land_tiles.blank?

    x_length ||= land_tiles.max_by { |k| k[:x] }[:x]
    y_length ||= land_tiles.max_by { |k| k[:y] }[:y]

    islands = []

    (1..y_length).each do |y|
      (1..x_length).each do |x|
        next if get_tile(x, y).blank?

        island = []

        aggregate_island_tiles(x, y, island)

        islands << island
      end
    end

    islands
  end

  private

  def aggregate_island_tiles(x, y, island)
    tile = get_tile(x, y)
    return if tile.blank?

    # add current tile to the current island
    island << tile

    # exclude current tile from tiles
    self.land_tiles = land_tiles - [tile]

    aggregate_island_tiles(x + 1, y, island)
    aggregate_island_tiles(x, y + 1, island)
    aggregate_island_tiles(x - 1, y, island)
    aggregate_island_tiles(x, y - 1, island)
  end

  def get_tile(x, y)
    land_tiles.detect { |h| h[:x] == x && h[:y] == y }
  end
end