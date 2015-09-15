require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  test '#index' do
    get :index, format: :json

    #symbolize_names: true lets you use :name instead of 'name' in tests
    users = JSON.parse(response.body, symbolize_names: true)
    user = users.first

    assert_response :success
    # or assert_equal 200, response.status
    assert_equal 2, users.count
    assert_equal 'Lannister', user[:name]
    assert_equal 'sucks@sucks.com', user[:email]
  end

  test '#show' do
    #need to identify this get with an id, as below
    get :show, format: :json, id: User.first.id

    user = JSON.parse(response.body, symbolize_names: true)
    assert_response :success
    assert_equal 'Lannister', user[:name]
    assert_equal 'sucks@sucks.com', user[:email]
  end

  test '#create' do
    #create the params you will get back, then associate them with user: in the post method
    user_params = {name: 'Arya', email: 'Is not blind'}
    post :create, format: :json, user: user_params

    user = User.last
    # below is a way to be more explicit with the api testing, and uses the extra assert_equals below
    json_user = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 'Arya', user.name
    assert_equal 'Arya', json_user[:name]
    assert_equal 'Is not blind', user.email
    assert_equal 'Is not blind', json_user[:email]
  end

  test '#update' do
    user_params = {name: 'Arya', email: 'Is not blind'}
    old_user = User.first

    put :update, format: :json, id: old_user.id, user: user_params

    new_user = User.find(old_user.id)

    assert_response :success
    assert_equal 'Arya', new_user.name
    assert_equal 'Is not blind', new_user.email
    refute_equal old_user.name, new_user.name
    refute_equal old_user.email, new_user.email
  end

  test '#destroy' do
    #two args for below assert
    assert_difference('User.count', -1) do
      delete :destroy, format: :json, id: User.first.id
    end

    assert_response :success
  end
end
