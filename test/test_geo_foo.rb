require 'geo_foo/core'
require 'helper'

class TestGeoFoo < ActiveSupport::TestCase

  test "database connection" do
    # perform a query first to 'wake-up' the connection
    assert_equal(query_scalar("SELECT 5").to_i, 5)
    assert ActiveRecord::Base.connected?, "database connection esteblished"
  end

  test "postgis database is present" do
    assert(query('SELECT count(*) FROM geometry_columns'))
  end

  test "as_point" do
    latitude = 5
    longitude = 42
    point = GeoFoo::Core.as_point latitude, longitude
    assert(query("SELECT #{point}"))
    assert_equal(query_scalar("SELECT ST_X(#{point})").to_i, 42)
    assert_equal(query_scalar("SELECT ST_Y(#{point})").to_i, 5)
  end
  
end
