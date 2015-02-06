require 'test_helper'

class PortalTest < ActiveSupport::TestCase
  test "save" do
    p1 = Portal.new
    assert_not p1.save, "Saved the portal without a name"

    p1 = Portal.new(:name => 'hoge', :lat => 35.6591171, :lng => 139.7036907)
    assert p1.save

    assert_raises ActiveRecord::RecordNotUnique do
      p2 = Portal.new(:name => 'fuga', :lat => 35.6591171, :lng => 139.7036907)
      p2.save
    end

    assert_equal 2, Portal.count
  end
end
