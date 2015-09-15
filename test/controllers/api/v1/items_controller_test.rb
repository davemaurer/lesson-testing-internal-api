require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test '#index' do
    get :index, format: :json

    items = JSON.parse(response.body)

    assert_response :success
    # or assert_equal 200, response.status
  end
end
