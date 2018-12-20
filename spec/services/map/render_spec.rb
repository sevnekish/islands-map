require 'rails_helper'

RSpec.describe Map::Render do
  describe '.call' do
    let!(:map) { create :map, :simple_map }
    let(:rendered_map) {
      <<-STR.strip_heredoc
        # ~ x ~
        # ~ ~ ~
        # x x ~
      STR
    }

    subject { Map::Render.call(map) }

    it 'returns string with serialized map matrix' do
      expect(subject).to eq(rendered_map)
    end

    context 'when map is blank' do
      let(:map) { nil }

      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end

    context 'when map do not have any tiles' do
      let(:map) { create :map }

      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end
  end
end