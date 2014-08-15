module RailsTemporaryData
  module ControllerHelpers
    extend ActiveSupport::Concern

    def set_tmp_data(key, data, expires_at = nil)
      tmp_data = TemporaryData.create!(:data => data, :expires_at => expires_at)
      session[key] = tmp_data.id
    end

    def get_tmp_data(key)
      tmp_data = TemporaryData.unexpired.find_by_id(session[key])
      session[key] = nil if tmp_data.nil?
      tmp_data
    end

    def clear_tmp_data(key)
      tmp_data = TemporaryData.unexpired.find_by_id(session[key])
      session[key] = nil
      tmp_data.destroy if tmp_data
    end

    def update_tmp_data(key, data)
      tmp_data = TemporaryData.unexpired.find_by_id(session[key]) 
      unless tmp_data.nil? 
        tmp_data.data = data
        tmp_data.save!
      else
        session[key] = nil
      end
    end
  end
end