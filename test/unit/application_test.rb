require 'test_helper'
require 'minitest/autorun'


class ApplicationTest < ActiveSupport::TestCase
  def setup
    u = Factory.create :user
    @attributes = {
      url: 'http://clienturl.com',
      redirect_uri: 'http://clienturl.com/auth/callback',
      client_secret: 'abc123',
      client_id: 'anid',
      user: u
    }
  end
  
  test 'should create an application with required fields' do
    assert Application.new(@attributes).save
  end

  [:url, :redirect_uri, :client_secret, :client_id, :user].each do |attribute|
    test "should fail to create an application missing #{attribute}" do
      @attributes.delete attribute
      refute Application.new(@attributes).save
    end
  end
end
