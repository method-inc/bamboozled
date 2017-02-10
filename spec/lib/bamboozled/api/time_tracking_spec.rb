require "spec_helper"

RSpec.describe "Time Tracking" do
  before do
    @client = Bamboozled.client(subdomain: "x", api_key: "x")
  end

  describe '#record' do
    context 'api success' do
      it 'gets the given record' do
        response = File.new("spec/fixtures/time_tracking_record_200_response.json")
        stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

        record = @client.time_tracking.record('37_2301_REG')

        expect(record).to be_a Hash
        expect(record['payRate']).to eq('19.0000')
        expect(record['employeeId']).to eq('40488')
      end
    end

    describe 'api failures' do
      context 'bad api key' do
        it 'should raise an error' do
          response = File.new("spec/fixtures/time_tracking_record_401_response.json")
          stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

          expect do
            @client.time_tracking.record('37_2301_REG')
          end.to raise_error(Bamboozled::AuthenticationFailed)
        end
      end
      context 'invalid company name' do
        it 'should raise an error' do
          response = File.new("spec/fixtures/time_tracking_record_404_response.json")
          stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

          expect do
            @client.time_tracking.record('37_2301_REG')
          end.to raise_error(Bamboozled::NotFound)
        end
      end
      context 'invalid time tracking id' do
        it 'should raise an error' do
          response = File.new("spec/fixtures/time_tracking_record_400_response.json")
          stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

          expect do
            @client.time_tracking.record('37_2301_REG')
          end.to raise_error(Bamboozled::BadRequest)
        end
      end
    end
  end

  describe '#add' do
    describe 'api success' do
      it 'should return a hash with the id of the created record' do
        response = File.new("spec/fixtures/time_tracking_add_200_response.json")
        stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

        data = {
          timeTrackingId: '37_2302_REG',
          employeeId: '40488',
          dateHoursWorked: '2016-08-12',
          payRate: '19.00',
          rateType: 'REG',
          hoursWorked: '4.5760'
        }
        record = @client.time_tracking.add(data)
        expect(record).to be_a Hash
        expect(record['id']).to eq('37_2302_REG')
      end
    end

    describe 'api failures' do
      context 'employee id does not exist' do
        it 'should not raise an error but should not have an object in the response payload' do
          response = File.new("spec/fixtures/time_tracking_add_empty_response.json")
          stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

          data = {
            timeTrackingId: '37_2302_REG',
            employeeId: '40488',
            dateHoursWorked: '2016-08-12',
            payRate: '19.00',
            rateType: 'REG',
            hoursWorked: '4.5760'
          }
          record = @client.time_tracking.add(data)
          expect(record).to be_a Hash
          expect(record['headers']['content-length']).to eq('0')
        end
      end
    end
  end

  describe '#adjust' do
    describe 'api success' do
      it 'should return a hash with the id of the created record' do
        response = File.new("spec/fixtures/time_tracking_adjust_200_response.json")
        stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

        record = @client.time_tracking.adjust('37_2302_REG', '4.8')
        expect(record).to be_a Hash
        expect(record['id']).to eq('37_2302_REG')
      end
    end

    describe 'api failures' do
      context 'time tracking id does not exist' do
        it 'should raise a Bad Request error' do
          response = File.new("spec/fixtures/time_tracking_adjust_400_response.json")
          stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

          expect do
            @client.time_tracking.adjust('37_2303_REG', '4.8')
          end.to raise_error(Bamboozled::BadRequest)
        end
      end
    end
  end
end
