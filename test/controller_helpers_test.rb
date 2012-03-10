require 'test_helper'

class ControllerHelpersTest < ActionController::TestCase
  
  def setup
    @controller = DummyController.new
  end
  
  test "set and get tmp data" do
    data = { "foo" => "bar" }
    expires_at = Time.current + 24.hours 
    
    get :set_data, :data => data, :expires_at => expires_at
    get :get_data
    
    @tmp_data = assigns(:tmp_data)
    
    assert_equal 1, session["test_data"]
    assert_equal data, @tmp_data.data
    assert_equal expires_at.to_a, @tmp_data.expires_at.to_a
  end
  
  test "@tmp_data should not be returned (=nil) and session cleared if it is expired in the meantime" do
    data = { "foo" => "bar" }
    expires_at = Time.current + 1.second
    
    get :set_data, :data => { "foo" => "bar" }, :expires_at => expires_at
    sleep 1
    get :get_data
    
    assert_nil session["test_data"]
    assert_nil assigns(:tmp_data)
  end
  
  test "#clear_tmp_data shoould destroy both tmp data and sessions value" do
    get :set_data, :data => { "foo" => "bar" }
    assert_equal 1, TemporaryData.count
    get :clear_data
    assert_equal 0, TemporaryData.count
    assert_nil session["test_data"]
  end

end
