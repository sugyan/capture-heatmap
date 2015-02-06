require 'test_helper'

class CapturedLogTest < ActiveSupport::TestCase
  test "save" do
    l = CapturedLog.new
    assert l.save

    assert_equal 3, CapturedLog.count
  end
end
