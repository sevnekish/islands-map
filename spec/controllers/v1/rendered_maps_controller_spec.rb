require 'rails_helper'

RSpec.describe V1::RenderedMapsController, type: :controller do
  describe 'GET #show' do
    subject { get :show }

    context 'success' do
      let!(:map) { create :map, :simple_map }
      let(:rendered_map) {
        <<-STR.strip_heredoc
          # ~ x ~
          # ~ ~ ~
          # x x ~
        STR
      }

      it { is_expected.to have_http_status :ok }

      it 'renders map' do
        subject
        expect(response.body).to eq(rendered_map)
      end
    end

    context 'failure' do
      context 'when the map not found' do
        it { is_expected.to have_http_status :not_found }

        it 'responds with error message' do
          subject
          expect(json_response[:error]).to eq('Map not found')
        end
      end
    end
  end
end
