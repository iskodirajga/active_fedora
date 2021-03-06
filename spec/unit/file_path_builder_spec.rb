require 'spec_helper'

describe ActiveFedora::FilePathBuilder do
  describe ".build" do
    let(:parent) { ActiveFedora::Base.new(id: '1234') }
    subject { described_class.build(parent, nil, 'FOO') }

    it { is_expected.to eq 'FOO1' }

    context "when some datastreams exist" do
      before do
        allow(parent).to receive(:attached_files).and_return('FOO56' => instance_double(ActiveFedora::File))
      end

      it { is_expected.to eq 'FOO57' }
    end
  end
end
