class V1::MapsController < V1::BaseController
  def create
    map = Map.first || Map::Retrieve.new(Settings.map_source_url).perform

    respond_with_serialized_resource_for(map, status: :created)
  end
end