module RailsTemporaryData
  module ControllerHelpers
    extend ActiveSupport::Concern

    def set_tmp_data(key, data, expires_at = nil, use_session = false)
      tmp_data = TemporaryData.create!(:data => data, :expires_at => expires_at, :key => key)
      session[key] = tmp_data.id if use_session
    end

    def get_tmp_data(key, use_session = false)
      tmp_data = if use_session
        TemporaryData.unexpired.find_by_id(session[key])
      else
        TemporaryData.unexpired.find_by(key: key)
      end
   
      session[key] = nil if tmp_data.nil? && use_session
      tmp_data
    end

    def clear_tmp_data(key, use_session = false)
      tmp_data = if use_session
        TemporaryData.unexpired.find_by_id(session[key])
      else
        TemporaryData.unexpired.find_by(key: key)
      end
      session[key] = nil if use_session
      tmp_data.destroy if tmp_data
    end

    def update_tmp_data(key, data, use_session = false)
      tmp_data = if use_session
        TemporaryData.unexpired.find_by_id(session[key])
      else
        TemporaryData.unexpired.find_by(key: key)
      end

      unless tmp_data.nil? 
        tmp_data.data = data
        tmp_data.save!
      else
        session[key] = nil if use_session
      end
    end
  end
end
