require 'rails_helper'

RSpec.describe V1::MapsController, type: :controller do
  describe 'POST #create' do
    let(:map) { Map.includes(:tiles, :islands).last }

    subject { post :create }

    context 'success', vcr: { cassette_name: 'new_map_success' } do
      it { is_expected.to have_http_status :created }

      it 'responds with serialized map' do
        subject

        expect(json_response[:map].slice(:id, :created_at)).to eq(
          id: map.id,
          created_at: map.created_at.to_s
        )

        expect(json_response[:map][:tiles].each { |h| h.delete(:id) }).to match_array(
          [
            { x: 1, y: 1, kind: 'land' },
            { x: 1, y: 2, kind: 'water' },
            { x: 1, y: 3, kind: 'water' },
            { x: 2, y: 1, kind: 'water' },
            { x: 2, y: 2, kind: 'water' },
            { x: 2, y: 3, kind: 'land' }
          ]
        )

        expect(json_response[:map][:islands]).to match_array(
          [
            { id: map.islands.first.id },
            { id: map.islands.second.id }
          ]
        )
      end
    end

    context 'when map is already created' do
      let!(:map) { create :map, :simple_map }

      it 'responds with same map' do
        subject
        expect(json_response[:map][:id]).to eq(map.id)
      end
    end
  end
end
