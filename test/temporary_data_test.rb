require 'test_helper'

class TemporaryDataTest < ActiveSupport::TestCase
  
  test "data column is serialized" do
    tmp_data = TemporaryData.create(:data => { :first_name => "Vlado", :last_name => "Cingel" })
    assert "Vlado", tmp_data.data[:first_name]
  end
  
  test "expires_at is set before create to time in future if blank (not provided) or set to past" do
    tmp_data_1 = TemporaryData.create(:data => {})
    assert tmp_data_1.expires_at > Time.current
    tmp_data_2 = TemporaryData.create(:data => {}, :expires_at => Time.current - 1.hour)
    assert tmp_data_2.expires_at > Time.current
  end
  
  test "expires_at is not set before create if provided" do
    expires_at = Time.current + 5.hours
    tmp_data = TemporaryData.create(:data => {}, :expires_at => expires_at)
    assert_equal expires_at, tmp_data.expires_at 
  end
  
  test "it should return all data (including expired) when no scope is defined" do
    tmp_data_1 = TemporaryData.create(:data => { :tmp_data => 1 }, :expires_at => Time.current + 1.second)
    tmp_data_2 = TemporaryData.create(:data => { :tmp_data => 2 }, :expires_at => Time.current + 1.hour)
    sleep 1 # wait for 1 second so tmp_data_1 expires
    tmp_data = TemporaryData.all
    assert tmp_data.include?(tmp_data_2)
    assert tmp_data.include?(tmp_data_1)
  end
  
  test "not_expired scope should return only not expired data by default" do
    tmp_data_1 = TemporaryData.create(:data => { :tmp_data => 1 }, :expires_at => Time.current + 1.second)
    tmp_data_2 = TemporaryData.create(:data => { :tmp_data => 2 }, :expires_at => Time.current + 1.hour)
    sleep 1 # wait for 1 second so tmp_data_1 expires
    tmp_data = TemporaryData.not_expired.all
    assert tmp_data.include?(tmp_data_2)
    assert !tmp_data.include?(tmp_data_1)
  end
  # 
  test "expired scope should return expired data when no scope is defined" do
    tmp_data_1 = TemporaryData.create(:data => { :tmp_data => 1 }, :expires_at => Time.current + 1.second)
    tmp_data_2 = TemporaryData.create(:data => { :tmp_data => 2 }, :expires_at => Time.current + 1.hour)
    sleep 1 # wait for 1 second so tmp_data_1 expires
    tmp_data = TemporaryData.expired.all
    assert !tmp_data.include?(tmp_data_2)
    assert tmp_data.include?(tmp_data_1)
  end
  
  test "delete_expired method should delete all temporary data with expires_at field in the past" do
    tmp_data_1 = TemporaryData.create(:data => { :tmp_data => 1 }, :expires_at => Time.current + 1.second)
    tmp_data_2 = TemporaryData.create(:data => { :tmp_data => 2 }, :expires_at => Time.current + 1.hour)
    assert_equal 2, TemporaryData.unscoped.count
    
    sleep 1 # wait for 1 second so tmp_data_1 expires
    TemporaryData.delete_expired
    assert_equal [tmp_data_2], TemporaryData.all
  end
  
end
