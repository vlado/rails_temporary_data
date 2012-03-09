class TemporaryData < ActiveRecord::Base
  serialize :data
  before_create :set_default_expires_at
  default_scope { where("expires_at > ?", Time.current) }
  
  private
    
    def set_default_expires_at
      self.expires_at = Time.current + 48.hours if expires_at.nil? || expires_at < Time.current
    end
end