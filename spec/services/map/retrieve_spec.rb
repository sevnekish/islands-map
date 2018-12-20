require 'rails_helper'

RSpec.describe Map::Retrieve do
  describe '#perform' do
    let(:source) { 'https://private-2e8649-advapi.apiary-mock.com/map' }

    subject { Map::Retrieve.new(source).perform }

    context 'success', vcr: { cassette_name: 'new_map_success' } do
      it 'creates new map' do
        expect { subject }.to change { Map.count }.by(1)
      end

      it 'creates 2 islands' do
        expect { subject }.to change { Island.count }.by(2)
      end

      it 'creates 9 tiles' do
        expect { subject }.to change { Tile.count }.by(6)
      end

      it 'returns new map with 2 islands and 6 tiles' do
        expect(subject).to be_persisted
        expect(subject.islands.count).to eq(2)
        expect(subject.tiles.count).to eq(6)
      end

      it 'creates islands with appropriate tiles' do
        expect(
          subject.islands.first.tiles.pluck(:x, :y, :kind)
        ).to match_array([[1, 1, 'land']])

        expect(
            subject.islands.second.tiles.pluck(:x, :y, :kind)
        ).to match_array([[2, 3, 'land']])
      end

      it 'creates appropriate tiles' do
        expect(subject.tiles.pluck(:x, :y, :kind)).to match_array(
          [
            [1, 1, 'land'],
            [1, 2, 'water'],
            [1, 3, 'water'],
            [2, 1, 'water'],
            [2, 2, 'water'],
            [2, 3, 'land']
          ]
        )
      end
    end
  end
end
