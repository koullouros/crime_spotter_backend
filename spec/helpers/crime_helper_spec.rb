require 'rails_helper'

# Tests requests to the data police API for crime data in CrimeHelper
RSpec.describe CrimeHelper, type: :helper do
  let(:valid_query) do
    crime_helper('52.268,0.543:52.794,0.238:52.130,0.478')
  end

  let(:invalid_query) do
    crime_helper(nil)
  end

  let(:date_request) do
    get_latest_crime_date
  end

  context 'when using valid attributes' do
    it 'should provide crime data' do
      expect(valid_query).not_to be_empty
    end

    it 'should contain all the required information' do
      valid_query.each do |crime|
        expect(crime[:category]).not_to be_nil
        expect(crime[:crime_date]).not_to be_nil
        expect(crime[:street]).not_to be_nil
        expect(crime[:extra_info]).not_to be_nil
        expect(crime[:latitude]).not_to be_nil
        expect(crime[:longitude]).not_to be_nil
      end
    end
  end

  context 'when using nil attributes' do
    it 'should return nil' do
      expect(invalid_query).to be_nil
    end
  end

  context 'calling get_latest_crime_date' do
    it 'returns a date' do
      expect(Date.parse(date_request)).to be_an_instance_of(Date)
    end
  end
end
