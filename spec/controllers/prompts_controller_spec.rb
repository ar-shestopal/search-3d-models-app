# spec/controllers/prompts_controller_spec.rb
require 'rails_helper'

require 'pry'

RSpec.describe PromptsController, type: :controller do
  describe 'GET #index' do
    it 'assigns all prompts to @prompts' do
      let!(:prompt1) { create(:prompt, description: 'Test prompt 1') }
      let!(:prompt2) { create(:prompt, description: 'Test prompt 2') }

      get :index

      expect(assigns(:prompts)).to eq([prompt2, prompt1])
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe 'POST #search' do
    let!(:prompt1) { create(:prompt, description: 'Test prompt 1') }
    let!(:prompt2) { create(:prompt, description: 'Test prompt 2') }
    let!(:prompt3) { create(:prompt, description: 'Another prompt') }

    before do
      Prompt.__elasticsearch__.refresh_index!(force: true)
    end

    context 'when search query is present' do
      it 'returns matching prompts' do
        post :search, params: { q: 'Test' }

        expect(response).to have_http_status(:success)

        expect(assigns(:prompts)).to match_array([prompt1, prompt2])
      end
    end

    context 'when search query is empty' do
      it 'returns no prompts' do
        post :search, params: { q: '' }

        expect(response).to have_http_status(:success)
        expect(assigns(:prompts)).to match_array([])
      end
    end
  end
end
