require 'rails_helper'

describe Snippets::ApplicationController do
  describe '.parent_prefixes' do
    let(:parent_prefixes) { Snippets::SnippetsController.parent_prefixes }
    before do
      Snippets.controller_prefix = prefix
    end

    context 'with controller_prefix' do
      let(:prefix) { 'some/path' }
      specify { expect(parent_prefixes.first).to eq 'some/path' }
    end

    context 'without controller_prefix' do
      let(:prefix) { nil }
      specify { expect(parent_prefixes.first).to_not eq nil }
    end
  end
end
