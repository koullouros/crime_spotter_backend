require 'rails_helper'

# Tests the Create and Update abilities of the CrimeEntriesController
RSpec.describe CrimeEntriesController, type: :controller do
  let(:valid_attributes) do
    location = Location.new(name: 'Location1',
                            updated: '2021-02-01')

    { name: 'Crime1',
      value: 50,
      month: '2021-02-01',
      location: location }
  end

  let(:invalid_attributes) do
    location = Location.new(name: nil,
                            updated: nil)
    { name: nil,
      value: nil,
      month: nil,
      location: location }
  end

  describe 'Create crime_entry' do
    context 'with valid parameters' do
      it 'creates a new crime_entry' do
        expect do
          CrimeEntry.create! valid_attributes
        end.to change(CrimeEntry, :count).by(1)
      end

      it 'can be retrieved after creation' do
        CrimeEntry.create! valid_attributes

        crime_entry = CrimeEntry.find_by(location: Location.find_by(name: 'Location1'))

        expect(crime_entry.name).to eq('Crime1')
        expect(crime_entry.value).to eq(50)
        expect(crime_entry.month).to eq(Date.parse('2021-02-01'))
        expect(crime_entry.location.name).to eq('Location1')
        expect(crime_entry.location.updated).to eq(Date.parse('2021-02-01'))
      end
    end

    context 'with invalid parameters' do
      it 'should fail to create a crime_entry' do
        expect do
          CrimeEntry.create invalid_attributes
        end.to_not change(CrimeEntry, :count)
      end
    end
  end

  describe 'Update crime_entry' do
    context 'with valid parameters' do
      let(:new_attributes) do
        location = Location.new(name: 'Location2',
                                updated: '2021-03-01')
        { name: 'Crime2',
          value: 75,
          month: '2021-03-01',
          location: location }
      end
      it 'successfully updates the crime_entry' do
        crime_entry = CrimeEntry.create! valid_attributes

        crime_entry.update!(new_attributes)

        expect(crime_entry.name).to eq('Crime2')
        expect(crime_entry.value).to eq(75)
        expect(crime_entry.month).to eq(Date.parse('2021-03-01'))
        expect(crime_entry.location.name).to eq('Location2')
        expect(crime_entry.location.updated).to eq(Date.parse('2021-03-01'))
      end
    end

    context 'with invalid parameters' do
      it 'does not change the saved crime_entry' do
        crime_entry = CrimeEntry.create! valid_attributes

        expect do
          crime_entry.update! invalid_attributes
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end