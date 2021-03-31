require 'test_helper'

class CrimeEntryTest < ActiveSupport::TestCase

  test 'should not save empty crime entry' do
    c = CrimeEntry.new

    c.save

    refute c.valid?
  end

  test 'should save valid crime entry' do
    # Create valid location
    l = Location.new

    l.name = 'London'
    l.updated = Date.parse('2021-02-01')

    l.save

    # Create valid crime entry
    c = CrimeEntry.new
    c.location = l
    c.name = 'violent-crime'
    c.value = 12
    c.month = Date.parse('2021-02-01')

    c.save

    assert c.valid?
  end

end
