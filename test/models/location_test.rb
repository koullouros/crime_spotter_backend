require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  test 'should not save empty location' do
    l = Location.new

    l.save
    refute l.valid?
  end

  test 'should save valid location' do
    l = Location.new

    l.name = 'London'
    l.updated = Date.parse('2021-02-01')

    l.save
    assert l.valid?
  end

  test 'should not save location with non-unique name' do
    # Create two of the exact same location
    l1 = Location.new

    l1.name = 'London'
    l1.updated = Date.parse('2021-02-01')

    l2 = Location.new

    l2.name = 'London'
    l2.updated = Date.parse('2021-02-01')

    l1.save
    l2.save
    # First should save successfully..
    assert l1.valid?
    # second should not
    refute l2.valid?
  end

end
