require 'rails_helper'

describe Snippets::SnippetsController do
  routes { Snippets::Engine.routes }

  let(:snippet) { Snippets::Snippet.new(id: 1) }

  describe 'GET index' do
    before do
      allow(Snippets::Snippet).to receive(:all_with_defaults).and_return([snippet])
      get :index, {}
    end

    it 'assigns all snippets as @snippets' do
      expect(assigns(:snippets)).to eq([snippet])
    end
  end

  describe 'GET search' do
    before do
      allow(Snippets::Snippet).to receive(:search).and_return([snippet])
      get :search, { q: 'test' }
    end

    it 'assigns all snippets as @snippets' do
      expect(assigns(:snippets)).to eq([snippet])
    end
  end

  describe 'GET new' do
    it 'assigns a new snippet as @snippet' do
      get :new, {}
      expect(assigns(:snippet)).to be_a_new(Snippets::Snippet)
    end
  end

  describe 'GET edit' do
    before do
      allow(Snippets::Snippet).to receive(:find).with('1').and_return(snippet)
      get :edit, id: 1
    end

    it 'assigns the requested snippet as @snippet' do
      expect(assigns(:snippet)).to eq(snippet)
    end
  end

  describe 'POST create' do
    let!(:snippet) { Snippets::Snippet.new id: 1 }

    before do
      allow(Snippets::Snippet).to receive(:new).and_return(snippet)
    end

    describe 'with valid params' do
      before do
        expect(snippet).to receive(:save).and_return(true)
        post :create, snippet: { title: 'Title' }
      end

      it 'assigns a newly created snippet as @snippet' do
        expect(assigns(:snippet)).to be_a(Snippets::Snippet)
      end

      it 'redirects to the created snippet' do
        expect(response).to redirect_to(snippet)
      end
    end

    describe 'with invalid params' do
      before do
        expect(snippet).to receive(:save).and_return(false)
        post :create, snippet: { title: 'invalid value' }
      end

      it 'assigns a newly created but unsaved snippet as @snippet' do
        expect(assigns(:snippet)).to be_a_new(Snippets::Snippet)
      end

      it 're-renders the "new" template' do
        expect(response).to render_template('new')
      end
    end

    describe 'with missing params' do
      it 'raises parameter missing error' do
        expect { put :create, snippet: {} }.to raise_error(
          ActionController::ParameterMissing
        )
      end
    end
  end

  describe 'PUT update' do
    before do
      allow(Snippets::Snippet).to receive(:find).with('1').and_return(snippet)
    end

    describe 'with valid params' do
      before do
        expect(snippet).to receive(:update).and_return(true)
        put :update, id: 1, snippet: { title: 'Title' }
      end

      it 'assigns the requested snippet as @snippet' do
        expect(assigns(:snippet)).to eq(snippet)
      end

      it 'redirects to the snippet' do
        expect(response).to redirect_to(snippet)
      end
    end

    describe 'with invalid params' do
      before do
        expect(snippet).to receive(:update).and_return(false)
        put :update, id: 1, snippet: { title: 'invalid value' }
      end

      it 'assigns the snippet as @snippet' do
        expect(assigns(:snippet)).to eq(snippet)
      end

      it 're-renders the "edit" template' do
        expect(response).to render_template('edit')
      end
    end

    describe 'with missing params' do
      it 'raises parameter missing error' do
        expect { put :update, id: 1, snippet: {} }.to raise_error(
          ActionController::ParameterMissing
        )
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      allow(Snippets::Snippet).to receive(:find).with('1').and_return(snippet)
    end

    it 'redirects to the snippets list' do
      expect(snippet).to receive(:destroy)
      delete :destroy, id: 1
      expect(response).to redirect_to(snippets_url)
    end
  end

  describe '#redirect_params' do
    subject { controller.send(:redirect_params) }

    context 'with stored params' do
      before do
        controller.stub(:session) do
          { stored_params: { page: 1 } }
        end
      end

      it { should eq({ page: 1 }) }
    end

    context 'without stored params' do
      before do
        controller.stub(:session) do
          {}
        end
      end

      it { should eq({}) }
    end
  end
end
