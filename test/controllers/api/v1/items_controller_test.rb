require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test '#index' do
    get :index, format: :json

    #symbolize_names: true lets you use :name instead of 'name' in tests
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    # or assert_equal 200, response.status
    assert_equal 2,                    items.count
    assert_equal 'Lannister',          item[:name]
    assert_equal 'My uncle is my dad', item[:description]
  end

  test '#show' do
    #need to identify this get with an id, as below
    get :show, format: :json, id: Item.first.id

    item = JSON.parse(response.body, symbolize_names: true)
    assert_response :success
    assert_equal 'Lannister',          item[:name]
    assert_equal 'My uncle is my dad', item[:description]
  end

  test '#create' do
    #create the params you will get back, then associate them with item: in the post method
    item_params = { name: 'Arya', description: 'Is not blind' }
    post :create, format: :json, item: item_params

    item = Item.last
    # below is a way to be more explicit with the api testing, and uses the extra assert_equals below
    json_item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 'Arya', item.name
    assert_equal 'Arya', json_item[:name]
    assert_equal 'Is not blind', item.description
    assert_equal 'Is not blind', json_item[:description]
  end

  test '#update' do
    item_params = {name: 'Arya', description: 'Is not blind'}
    old_item = Item.first

    put :update, format: :json, id: old_item.id, item: item_params

    new_item = Item.find(old_item.id)

    assert_response :success
    assert_equal 'Arya', new_item.name
    assert_equal 'Is not blind', new_item.description
    refute_equal old_item.name, new_item.name
    refute_equal old_item.description, new_item.description
  end

  test '#destroy' do
    #two args for below assert
    assert_difference('Item.count', -1) do
      delete :destroy, format: :json, id: Item.first.id
    end

    assert_response :success
  end
end
