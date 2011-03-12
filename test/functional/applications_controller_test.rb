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
    u = Factory.create :user
    Factory.create :application, user: Factory.create(:user)
    2.times { Factory.create :application, user: u }
    @controller.sign_in u
    get :index
    assert_response :success
    assert_equal assigns(:applications).size, 2
  end

  test "should get show" do
    Factory.create :application, id: 123
    get :show, id: '123'
    assert_response :success
    refute_nil assigns(:application)
  end

  test "should get show with no application existing" do
    get :show, id: '123'
    assert_response :success
    assert_nil assigns(:application)
  end

  test "should get new" do
    get :new
    assert_response :success
    refute_nil assigns(:application)
    assert_nil assigns(:application).id
  end

  test "should get edit" do
    Factory.create :application, id: 123
    get :edit, id: '123'
    assert_response :success
    refute_nil assigns(:application)
    assert_equal assigns(:application).id, 123
  end

  test "should get create" do
    attributes = Factory.build(:application).attributes
    get :create, application: attributes
    app = Application.last
    pp app
    assert_redirected_to controller: 'applications', action: 'show', id: app.id
    [:client_id, :client_secret, :redirect_uri, :url].each do |attribute|
      assert_equal app.send(attribute), attributes[attribute]
    end
  end

  test "should get update" do
    get :update, id: '123'
    assert_response :success
  end

  test "should get destroy" do
    get :destroy, id: '123'
    assert_response :success
  end

end
