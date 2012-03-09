class TemporaryData < ActiveRecord::Base
  serialize :data
  before_create :set_default_expires_at
  
  scope :unexpired, lambda { where("expires_at > ?", Time.current) }
  scope :expired, lambda { where("expires_at < ?", Time.current) }
  
  def self.delete_expired
    expired.delete_all
  end
  
  def self.not_expired
    unexpired
  end
  
  private
    
    def set_default_expires_at
      self.expires_at = Time.current + 48.hours if expires_at.nil? || expires_at < Time.current
    end
end