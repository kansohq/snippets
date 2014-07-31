require 'rails_helper'

describe Snippets::SnippetDefaults do
  let(:translations) do
    {
      en: {
        site_name: 'Manor Cottages',
        cottages: { river: 'River Cottage' }
      }
    }
  end

  describe '.all' do
    let(:backend) { double('backend') }
    let(:defaults) { Snippets::SnippetDefaults.all }
    let(:snippet1_attributes) { defaults.first.attributes.symbolize_keys }
    let(:snippet2_attributes) { defaults.last.attributes.symbolize_keys }

    before do
      allow(I18n::Backend::Simple).to receive(:new).and_return(backend)
      allow(backend).to receive(:load_translations)
      allow(backend).to receive(:translations).and_return(translations)
    end

    it 'return flattened and mapped snippets' do
      expect(snippet1_attributes).to include(key: 'site_name', value: 'Manor Cottages')
      expect(snippet2_attributes).to include(key: 'cottages.river', value: 'River Cottage')
    end
  end
end
