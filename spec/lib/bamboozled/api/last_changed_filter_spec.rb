require "spec_helper"

RSpec.describe Bamboozled::API::LastChangedFilter do
  subject { described_class.to_xml(hide_null, last_changed_filter) }
  context "when last changed date is set" do
    let(:last_changed_filter) { 1.year.ago.to_iso8601 }

    context "when hide null is true" do
      let(:hide_null) { true }

      it "returns the filters as xml" do
        expect(subject).to eq "<filters><lastChanged><includeNull></includeNull><lastChanged>" \
                              "<includeNull>no</includeNull><value>#{date.to_iso8601}</value>" \
                              "</lastChanged></filters>"
      end
    end

    context "when hide null is false" do
      let(:hide_null) { false }

      it "returns the filters as xml" do
        expect(subject).to eq "<filters><lastChanged><includeNull></includeNull><lastChanged>" \
                              "<value>#{date.to_iso8601}</value></lastChanged></filters>"
      end
    end
  end

  context "when last changed date is not set" do
    let(:last_changed_filter) { nil }

    context "when hide null is true" do
      let(:hide_null) { true }

      it "returns the filters as xml" do
        expect(subject).to eq "<filters><lastChanged><includeNull></includeNull><lastChanged>" \
                              "<includeNull>no</includeNull></lastChanged></filters>"
      end
    end

    context "when hide null is false" do
      let(:hide_null) { false }

      it "returns the filters as xml" do
        expect(subject).to eq "<filters><lastChanged><includeNull></includeNull><lastChanged>" \
                              "</lastChanged></filters>"
      end
    end
  end
end
