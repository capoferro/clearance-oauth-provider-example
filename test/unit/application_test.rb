require 'test_helper'
require 'minitest/autorun'


class ApplicationTest < ActiveSupport::TestCase
  def setup
    u = Factory.create :user
    @attributes = {
      url: 'http://clienturl.com',
      redirect_uri: 'http://clienturl.com/auth/callback',
      user: u
    }
  end
  
  test 'should create an application with required fields' do
    assert Application.new(@attributes).save
  end

  [:url, :redirect_uri, :user].each do |attribute|
    test "should fail to create an application missing #{attribute}" do
      @attributes.delete attribute
      refute Application.new(@attributes).save
    end
  end

  test 'should generate a new client id and client secret on create' do
    app = Application.create(@attributes)
    refute_nil app.client_id
    refute_nil app.client_secret
  end

  test 'should not allow the client id or secret to be modified' do
    app = Factory.create :application
    id = app.client_id
    secret = app.client_secret
    app.client_id = 'somethingnew'
    app.client_secret = 'somenewsecret'
    app.save!
    assert_equal app.client_id, id
    assert_equal app.client_secret, secret
  end
end
