require 'rails_helper'

RSpec.describe IslandTilesAggregator do
  # 0 0 0
  # 1 0 0
  # 0 1 1
  let(:land_tiles) do
    [
      { x: 1, y: 2, type: 'land' },
      { x: 2, y: 3, type: 'land' },
      { x: 3, y: 3, type: 'land' }
    ]
  end

  subject { IslandTilesAggregator.new(land_tiles).perform }

  it 'returns array of grouped tiles that share same edge' do
    expect(subject).to eq(
      [
        [
          { x: 1, y: 2, type: 'land' }
        ],
        [
          { x: 2, y: 3, type: 'land' },
          { x: 3, y: 3, type: 'land' }
        ]
      ]
    )
  end

  context 'when there is no land tiles' do
    let(:land_tiles) { [] }

    it 'returns empty array' do
      expect(subject).to eq([])
    end
  end

  context 'when map matrix is 5x5 and contains 5 islands' do
    # 1 1 0 0 1
    # 0 1 0 0 1
    # 0 0 1 0 1
    # 1 1 0 0 0
    # 1 1 0 0 1
    let(:land_tiles) do
      [
        { x: 1, y: 1, type: 'land' },
        { x: 1, y: 4, type: 'land' },
        { x: 1, y: 5, type: 'land' },
        { x: 2, y: 1, type: 'land' },
        { x: 2, y: 2, type: 'land' },
        { x: 2, y: 4, type: 'land' },
        { x: 2, y: 5, type: 'land' },
        { x: 3, y: 3, type: 'land' },
        { x: 5, y: 1, type: 'land' },
        { x: 5, y: 2, type: 'land' },
        { x: 5, y: 3, type: 'land' },
        { x: 5, y: 5, type: 'land' }
      ]
    end

    it 'returns array of grouped tiles that share same edge' do
      expect(subject).to eq(
        [
          [
            { x: 1, y: 1, type: 'land' },
            { x: 2, y: 1, type: 'land' },
            { x: 2, y: 2, type: 'land' }
          ],
          [
            { x: 5, y: 1, type: 'land' },
            { x: 5, y: 2, type: 'land' },
            { x: 5, y: 3, type: 'land' }
          ],
          [
            { x: 3, y: 3, type: 'land' }
          ],
          [
            { x: 1, y: 4, type: 'land' },
            { x: 2, y: 4, type: 'land' },
            { x: 2, y: 5, type: 'land' },
            { x: 1, y: 5, type: 'land' }
          ],
          [
            { x: 5, y: 5, type: 'land' }
          ]
        ]
      )
    end
  end

  context 'when map matrix is 5x5 and contains 1 island' do
    # 0 0 0 0 0
    # 0 0 1 0 0
    # 0 1 1 1 0
    # 0 1 1 0 0
    # 0 0 0 0 0
    let(:land_tiles) do
      [
        { x: 2, y: 3, type: 'land' },
        { x: 2, y: 4, type: 'land' },
        { x: 3, y: 2, type: 'land' },
        { x: 3, y: 3, type: 'land' },
        { x: 3, y: 4, type: 'land' },
        { x: 4, y: 3, type: 'land' }
      ]
    end

    it 'returns array of grouped tiles that share same edge' do
      expect(subject).to eq(
        [
          [
            { x: 3, y: 2, type: 'land' },
            { x: 3, y: 3, type: 'land' },
            { x: 4, y: 3, type: 'land' },
            { x: 3, y: 4, type: 'land' },
            { x: 2, y: 4, type: 'land' },
            { x: 2, y: 3, type: 'land' }
          ]
        ]
      )
    end
  end

  context 'when map matrix is 5x5 and contains 1 island' do
    # 0 0 0 0 0
    # 0 1 0 0 1
    # 0 1 0 0 1
    # 0 1 1 1 1
    # 0 0 0 0 0,

    let(:land_tiles) do
      [
        { x: 2, y: 2, type: 'land' },
        { x: 2, y: 3, type: 'land' },
        { x: 2, y: 4, type: 'land' },
        { x: 3, y: 4, type: 'land' },
        { x: 4, y: 4, type: 'land' },
        { x: 5, y: 2, type: 'land' },
        { x: 5, y: 3, type: 'land' },
        { x: 5, y: 4, type: 'land' }
      ]
    end

    it 'returns array of grouped tiles that share same edge' do
      expect(subject).to eq(
        [
          [
            { x: 2, y: 2, type: 'land' },
            { x: 2, y: 3, type: 'land' },
            { x: 2, y: 4, type: 'land' },
            { x: 3, y: 4, type: 'land' },
            { x: 4, y: 4, type: 'land' },
            { x: 5, y: 4, type: 'land' },
            { x: 5, y: 3, type: 'land' },
            { x: 5, y: 2, type: 'land' }
          ]
        ]
      )
    end
  end
end
