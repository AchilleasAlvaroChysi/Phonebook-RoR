require 'test_helper'

class DetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get details_new_url
    assert_response :success
  end

  test "should get create" do
    get details_create_url
    assert_response :success
  end

  test "should get destroy" do
    get details_destroy_url
    assert_response :success
  end

end
