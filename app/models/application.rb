require 'digest/md5'

class Application < ActiveRecord::Base

  validates_presence_of :url, :redirect_uri, :client_secret, :client_id, :user_id

  belongs_to :user

  before_validation :generate_client_credentials
  before_update :unmodify_client_credentials

  private

  def generate_client_credentials
    self.client_id = Digest::MD5.hexdigest "#{self.url}#{Time.now.to_i}" if self.client_id.nil?
    self.client_secret = Digest::MD5.hexdigest "#{Time.now.to_i}#{self.url}" if self.client_secret.nil?
  end

  def unmodify_client_credentials
    self.client_id = self.client_id_was if self.client_id_changed?
    self.client_secret = self.client_secret_was if self.client_secret_changed?
  end
  
end
