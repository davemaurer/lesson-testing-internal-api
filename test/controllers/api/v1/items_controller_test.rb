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

    assert_response :success
    assert_equal 'Arya', item.name
    assert_equal 'Is not blind', item.description
  end
end
