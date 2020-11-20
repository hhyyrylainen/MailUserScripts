# frozen_string_literal: true

require 'test/unit'

require_relative '../lib/password'

# Test for Password
class TestHashGeneration < Test::Unit::TestCase
  def test_simple
    assert_equal('{SSHA512}K74MSLkafRuKZ1Ooucvh2xa4Q3nz+R/hFWIShN96SPHNcem+uQ6mFMe9kk' \
                   'JQqp5EaoZnJeaFpl310TmlzRgNyTEyMzQ=',
                 Password.new('test', '1234').dovecot_entry)
    assert_equal('{SSHA512}gIGREc+k4705S+Q9JTINbSmEmQOt3hVC5/O6BQLWykNdX1JPRCsccg6q4i' \
                   'MlA5+DoqmJerHUVfVnPUPi0F/pTDU2Nzg=',
                 Password.new('password', '5678').dovecot_entry)
  end
end
