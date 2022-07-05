module RailsTemporaryData
  module ControllerHelpers
    extend ActiveSupport::Concern

    def set_tmp_data(key, data, expires_at = nil)
      tmp_data = TemporaryData.create!(:data => data, :expires_at => expires_at, :key => key)
    end
    
    def set_or_update_tmp_data(key, data, expires_at = nil)
      tmp_data = TemporaryData.unexpired.find_by(key: key)
      tmp_data.present? ? update_tmp_data(key, tmp_data.data + data) : set_tmp_data(key, data)
      
      TemporaryData.unexpired.find_by(key: key)
    end

    def get_tmp_data(key)
      TemporaryData.unexpired.find_by(key: key)
    end

    def clear_tmp_data(key)
      TemporaryData.unexpired.where(key: key).delete_all
    end

    def update_tmp_data(key, data)
      tmp_data = TemporaryData.unexpired.find_by(key: key)

      unless tmp_data.nil? 
        tmp_data.data = data
        tmp_data.save!
      end
    end
  end
end
