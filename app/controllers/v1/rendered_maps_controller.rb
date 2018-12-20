class V1::RenderedMapsController < V1::BaseController
  def show
    map = Map.includes(:tiles).last!

    render plain: Map::Render.call(map)
  end
end