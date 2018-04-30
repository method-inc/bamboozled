require 'spec_helper'

RSpec.describe Bamboozled::API::FieldCollection do
  let(:field_collection) { described_class.new(['hireDate', 'location'])}

  describe '#to_csv' do
    it 'returns the fields as a csv' do
      expect(field_collection.to_csv).to eq 'hireDate,location'
    end
  end

  describe '#to_xml' do
    it 'returns the fields as xml' do
      expect(field_collection.to_xml).to eq '<fields><field id="hireDate" /><field id="location" /></fields>'
    end
  end
end
