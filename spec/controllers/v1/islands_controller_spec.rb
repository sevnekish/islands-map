require 'rails_helper'

RSpec.describe V1::IslandsController, type: :controller do
  tiles_to_a = ->(tiles) do
    tiles.map { |t| { id: t.id, kind: t.kind.to_s, x: t.x, y: t.y } }
  end

  describe 'GET #index' do

    subject { get :index }

    context 'when there is a map with 2 islands' do
      let!(:map) { create :map, :simple_map }

      let(:island_1) { map.islands.first }
      let(:island_2) { map.islands.second }

      it { is_expected.to have_http_status :ok }

      it 'responds with serialized collection of islands' do
        subject
        expect(json_response[:islands]).to match_array(
          [
            {
              id: island_1.id,
              tiles: tiles_to_a.call(island_1.tiles)
            },
            {
              id: island_2.id,
              tiles: tiles_to_a.call(island_2.tiles)
            }
          ]
        )
      end
    end

    context 'when there is no islands' do
      it { is_expected.to have_http_status :ok }

      it 'responds with empty collection' do
        subject
        expect(json_response[:islands]).to eq([])
      end
    end
  end

  describe 'GET #show' do
    let!(:map) { create :map, :simple_map }

    let(:island) { map.islands.first }
    let(:island_id) { island.id }

    subject { get :show, params: { id: island_id } }

    it { is_expected.to have_http_status :ok }

    it 'responds with serialized island' do
      subject
      expect(json_response[:island]).to eq(
        id: island.id,
        tiles: tiles_to_a.call(island.tiles)
      )
    end

    context 'failure' do
      context 'when the island not found' do
        let(:island_id) { 99999 }

        it { is_expected.to have_http_status :not_found }

        it 'responds with error message' do
          subject
          expect(json_response[:error]).to eq('Island not found')
        end
      end
    end
  end
end
