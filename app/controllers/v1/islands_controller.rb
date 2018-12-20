class V1::IslandsController < V1::BaseController
  def index
    respond_with_serialized_list_for(
      Island.all.includes(:tiles),
      include_tiles: true,
      each_serializer: V1::IslandSerializer
    )
  end

  def show
    respond_with_serialized_resource_for(
      Island.find(params[:id]),
      include_tiles: true
    )
  end
end