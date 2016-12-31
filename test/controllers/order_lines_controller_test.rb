require 'test_helper'

class OrderLinesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get order_lines_create_url
    assert_response :success
  end

  test "should get update" do
    get order_lines_update_url
    assert_response :success
  end

  test "should get destroy" do
    get order_lines_destroy_url
    assert_response :success
  end

end
