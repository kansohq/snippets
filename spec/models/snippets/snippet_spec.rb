require 'rails_helper'

describe Snippets::Snippet do
  subject(:snippet) { Snippets::Snippet.make }

  describe 'blueprint' do
    it { is_expected.to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :key }
    it { is_expected.to validate_presence_of :value }
    it { is_expected.to validate_uniqueness_of :key }
  end

  describe 'callbacks' do
    it 'calls cache on save' do
      expect(snippet).to receive(:cache)
      snippet.run_callbacks :save
    end

    it 'calls clear_cache on destroy' do
      expect(snippet).to receive(:clear_cache)
      snippet.run_callbacks :destroy
    end
  end

  describe '.all_with_defaults' do
    subject { Snippets::Snippet.all_with_defaults }
    let(:snippet1) { double('snippet', key: 'foo') }
    let(:default_snippet1) { double('snippet', key: 'foo') }
    let(:default_snippet2) { double('snippet', key: 'bar') }

    before do
      allow(Snippets::Snippet).to receive(:all).and_return([snippet1])
      allow(Snippets::SnippetDefaults).to receive(:all).and_return(
        [default_snippet1, default_snippet2]
      )
    end

    it 'combines snippets' do
      is_expected.to include snippet1
      is_expected.to include default_snippet2
    end

    it 'removes defaults of duplicate keys' do
      is_expected.to_not include default_snippet1
    end
  end

  describe '.search' do
    subject { Snippets::Snippet.search(string) }
    let(:snippet) do
      double('snippet', key: 'test', value: 'wibble')
    end

    before do
      Snippets::Snippet.stub(:all_with_defaults) { [snippet] }
    end 

    context 'string matches' do
      let(:string) { 'tes' }

      it { should include snippet }
    end

    context 'string does not match' do
      let(:string) { 'blar' }

      it { should_not include snippet }
    end
  end

  describe '.cache_all' do
    let(:snippet1) { double('snippet') }
    let(:snippet2) { double('snippet') }

    before do
      allow(Snippets::Snippet).to receive(:all).and_return([snippet1, snippet2])
    end

    it 'calls cache on all snippets' do
      expect(snippet1).to receive(:cache)
      expect(snippet2).to receive(:cache)
      Snippets::Snippet.cache_all
    end
  end

  describe '#cache' do
    let(:snippet) { Snippets::Snippet.make key: 'key', value: 'value' }

    context 'with change of key' do
      before do
        allow(snippet).to receive(:key_changed?).and_return(true)
        allow(snippet).to receive(:key_was).and_return('old_key')
      end

      it 'removes old key value and stores value' do
        expect(snippet).to receive(:store_value).with('old_key', nil)
        expect(snippet).to receive(:store_value).with('key', 'value')
        snippet.cache
      end
    end

    context 'with same key' do
      before do
        allow(snippet).to receive(:key_changed?).and_return(false)
      end

      it 'stores value' do
        expect(snippet).to receive(:store_value).with('key', 'value')
        snippet.cache
      end
    end

    it 'can retrieve value' do
      snippet.cache
      expect(I18n.t('key')).to eq('value')
    end
  end

  describe '#clear_cache' do
    let(:snippet) { Snippets::Snippet.make key: 'key', value: 'value' }

    it 'removes value' do
      expect(snippet).to receive(:store_value).with('key', nil)
      snippet.clear_cache
    end

    it 'cannot retrieve value' do
      snippet.clear_cache
      expect(I18n.t('key')).to_not eq('value')
    end
  end
end
