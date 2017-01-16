require 'test_helper'

class ShopControllerTest < ActionDispatch::IntegrationTest
  test "should get collections" do
    get shop_collections_url
    assert_response :success
  end

end
