require 'rails_helper'

# Tests the Create and Update abilities of the LocationsController
RSpec.describe LocationsController, type: :controller do
  let(:valid_attributes) do
    { name: 'Location1',
      updated: '2021-02-01' }
  end

  let(:invalid_attributes) do
    { name: nil,
      updated: nil }
  end

  describe 'Create location' do
    context 'with valid parameters' do
      it 'creates a new location' do
        expect do
          Location.create! valid_attributes
        end.to change(Location, :count).by(1)
      end

      it 'can be retrieved after creation' do
        Location.create! valid_attributes

        location = Location.find_by(name: 'Location1')

        expect(location.name).to eq('Location1')
        expect(location.updated).to eq(Date.parse('2021-02-01'))
      end
    end

    context 'with invalid parameters' do
      it 'should fail to create a location' do
        expect do
          Location.create invalid_attributes
        end.to_not change(Location, :count)
      end
    end
  end

  describe 'Update location' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'Location2',
          updated: '2021-03-01' }
      end
      it 'successfully updates the location' do
        location = Location.create! valid_attributes

        location.update!(new_attributes)

        expect(location.name).to eq('Location2')
        expect(location.updated).to eq(Date.parse('2021-03-01'))
      end
    end

    context 'with invalid parameters' do
      it 'does not change the saved location' do
        location = Location.create! valid_attributes

        expect do
          location.update! invalid_attributes
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
