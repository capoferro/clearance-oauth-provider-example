require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase

  test "should route to applications" do
    assert_routing '/account/applications', controller: 'applications', action: 'index'
  end

  test "should route to show application" do
    assert_routing '/account/applications/123', controller: 'applications', action: 'show', id: '123'
  end

  test "should route to new application" do
    assert_routing '/account/applications/new', controller: 'applications', action: 'new'
  end
  
  test "should route to edit an applications" do
    assert_routing '/account/applications/123/edit', controller: 'applications', action: 'edit', id: '123'
  end

  test "should route to create an application" do
    assert_routing({method: 'post', path: '/account/applications'}, {controller: 'applications', action: 'create'})
  end

  test "should route to update an application" do
    assert_routing({method: 'put', path: '/account/applications/123'}, {controller: 'applications', action: 'update', id: '123'})
  end

  test "should route to delete an application" do
    assert_routing({method: 'delete', path: 'account/applications/123'}, {controller: 'applications', action: 'destroy', id: '123'})
  end
  
  
  test "should get index" do
    login
    Factory.create :application, user: Factory.create(:user)
    2.times { Factory.create :application, user: @controller.current_user }
    get :index
    assert_response :success
    assert_equal assigns(:applications).size, 2
  end

  test "should get show" do
    login
    Factory.create :application, id: 123, user: @controller.current_user
    get :show, id: '123'
    assert_response :success
    refute_nil assigns(:application)
  end

  test "should not show applications owned by other users" do
    login
    Factory.create :application, id: 123, user: Factory.create(:user)
    get :show, id: '123'
    assert_redirected_to account_applications_path
  end

  test "should get show with no application existing" do
    login
    get :show, id: '123'
    assert_redirected_to account_applications_path
    assert_nil assigns(:application)
  end

  test "should get new" do
    login
    get :new
    assert_response :success
    refute_nil assigns(:application)
    assert_nil assigns(:application).id
  end

  test "should allow editing an application" do
    login
    Factory.create :application, id: 123, user: @controller.current_user
    get :edit, id: '123'
    assert_response :success
    refute_nil assigns(:application)
    assert_equal assigns(:application).id, 123
  end

  test "should create applications" do
    login
    attributes = {redirect_uri: 'http://app.url/redirectable', url: 'http://app.url'}
    get :create, application: attributes
    app = Application.last
    assert_equal assigns(:application).errors.count, 0, assigns(:application).errors.inspect
    assert_redirected_to controller: 'applications', action: 'show', id: app.id
    attributes.each do |k, v|
      assert_equal v, app.send(k)
    end
    assert_equal @controller.current_user.id, app.user_id

    # These should be generated on create
    [:client_id, :client_secret].each do |attribute|
      refute_nil app.send(attribute)
    end
  end

  [:redirect_uri, :url].each do |field|
    test "should allow #{field} to be updated" do
      login
      app = Factory.create :application, id: '123', user: @controller.current_user
      attributes = {field => 'http://updated.com/updated'}
      get :update, id: '123', application: attributes
      assert_equal assigns(:application).errors.count, 0, assigns(:application).errors.inspect
      assert_response :success
      assert_equal attributes[field], Application.where(id: 123).first.send(field)
    end
  end

  test "should not allow an application to be updated without being logged in" do
    login
    app = Factory.create :application, id: '123', user: Factory.create(:user)
    original_url = app.url
    attributes = {url: 'http://updated.com/updated'}
    get :update, id: '123', application: attributes
    assert_redirected_to account_applications_path
    assert_equal original_url, Application.where(id: '123').first.url
  end

  test "should get destroy" do
    login
    app = Factory.create :application, id: '123', user: @controller.current_user
    get :destroy, id: '123'
    assert_response :success
    assert_nil Application.where(id: '123').first
  end
  
  test "should should not allow other users to destroy" do
    login
    app = Factory.create :application, id: '123', user: Factory.create(:user)
    get :destroy, id: '123'
    assert_response :success
    refute_nil Application.where(id: '123').first
  end

end
