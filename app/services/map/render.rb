class Map::Render
  def self.call(map)
    return if map.blank?
    return if map.tiles.empty?

    # TODO: get max x y by one sql request or store cached size of the map in the map table
    x_length = map.tiles.maximum(:x)
    y_length = map.tiles.maximum(:y)

    # build 2d array of map tiles with water tiles as "~"
    matrix = []
    y_length.times { matrix << Array.new(x_length, '~') }

    # put land tiles as "x"
    map.tiles.land.each do |tile|
      matrix[tile[:y] - 1][tile[:x] - 1] = 'x'
    end

    str = ''
    matrix.each { |row| str += "# #{row.join(' ')}\n" }
    str
  end
end
