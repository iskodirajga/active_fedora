require 'spec_helper'

describe ActiveFedora::SolrHit do
  before do
    class Foo < ActiveFedora::Base
      property :title, predicate: ::RDF::Vocab::DC.title, multiple: false
    end
  end

  after do
    Object.send(:remove_const, :Foo)
  end

  let(:another) { Foo.create }

  let!(:obj) { Foo.create!(
    id: 'test-123',
    title: 'My Title'
  ) }

  let(:doc) { obj.to_solr }
  let(:solr_hit) { described_class.new(doc) }

  describe "#reify" do
    subject { solr_hit.reify }

    it "finds the document in solr" do
      expect(subject).to be_instance_of Foo
      expect(subject.title).to eq 'My Title'
    end
  end

  describe "#instantiate_with_json" do
    subject { solr_hit.instantiate_with_json }

    it { is_expected.to be_persisted }

    it "finds the document in solr" do
      expect(subject).to be_instance_of Foo
      expect(subject.title).to eq 'My Title'
    end
  end
end