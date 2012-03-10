class DummyController < ApplicationController
  
  def set_data
    set_tmp_data("test_data", params[:data], params[:expires_at])
    head :ok
  end
  
  def get_data
    @tmp_data = get_tmp_data("test_data")
    head :ok
  end
  
  def clear_data
    clear_tmp_data("test_data")
    head :ok
  end
  
end